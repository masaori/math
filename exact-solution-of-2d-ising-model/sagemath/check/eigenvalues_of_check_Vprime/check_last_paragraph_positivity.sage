# 対象ラベル: eigenvalues_of_check_Vprime
# eigenvalues_of_check_Vprime の証明の最後の段落
#   ǧ(ε) ∈ ℝ（主張の ǧ の定義。和は def_finite_sum_of_real_numbers の ℝ の有限和）なので
#   exp(ǧ(ε)) > 0   (∵ real_exp_positive (x → ǧ(ε)))
# を確かめる。real_exp_positive の証明の 2 本の鎖も x := ǧ(ε) で確かめる。
#   Step 1: exp(x)exp(-x) = exp(x + (-x)) = exp(0) = 1
#   Step 2: exp(x) = exp(x/2 + x/2) = exp(x/2)exp(x/2) = (exp(x/2))^2 ≥ 0
# 帰属: γ(θ̃_μ)・ǧ(ε)・exp は ℝ の元で、値は ℝ への脱出（arccosh・exp・cos の値）なので、
# 区間演算 RealBallField(200) の球で扱う（丸めの誤差を球の半径に含め、真の値を必ず囲む）。
# 球どうしの不等号は球の全体で成り立つときだけ真、等号の行は球が共通部分を持つこと（overlaps）で確かめる。
# overlaps は半径が広いと誤った行も通すので、比べる球の半径が 1e-40 未満であることも確かめる。
# K_1, K_2 は有理数で与える。
# M = 2..6、K の 4 組、全ての ε ∈ {0,1}^M。
# 否定コントロール 1: 鎖の行を 1 つ壊す（Step 1 の 2 行目を exp(x + x)、Step 2 の 3 行目を exp(x/2)exp(x)）と、
# ǧ(ε) ≠ 0 の ε で隣の行と球が交わらなくなることを確かめる。
# 否定コントロール 2: real_exp_positive の必要十分版が残した仮定（どの元も y + y の形に書ける）を外した
# ℤ 上の f(n) = (-1)^n は、和を積へ送り f(0) = 1 だが f(1) = -1 < 0 であることを確かめる。

RB = RealBallField(200)
pi_b = RB.pi()


def K_star_b(K):
    # 双対結合定数 K* := -(1/2) log(tanh K)（_shared/spin_ops.sage の K_star と同じ式）
    return -(RB(K).tanh().log()) / 2


def gamma_tilde_b(M, mu, K1, K2):
    # γ(θ̃_μ) := arccosh(γ_1(θ̃_μ))、γ_1(θ) = c_1c_2^* − s_1s_2^* cos θ、θ̃_μ = 2π(μ − 1/2)/M
    K2s = K_star_b(K2)
    c1, s1 = (2 * RB(K1)).cosh(), (2 * RB(K1)).sinh()
    c2s, s2s = (2 * K2s).cosh(), (2 * K2s).sinh()
    th = 2 * pi_b * (RB(mu) - RB(1) / 2) / M
    g1 = c1 * c2s - s1 * s2s * th.cos()
    assert g1 >= 1, ("gamma_1 < 1", M, mu, K1, K2)    # gamma1_lower_bound_all_theta（arccosh の定義域）
    return g1.arccosh()


def gcheck(M, eps, gam):
    # ǧ(ε) = Σ_{μ=1}^{M} γ(θ̃_μ)(ε_μ − 1/2)。def_finite_sum_of_real_numbers どおり左から足す
    s = gam[0] * (RB(eps[0]) - RB(1) / 2)
    for mu in range(1, M):
        s = s + gam[mu] * (RB(eps[mu]) - RB(1) / 2)
    return s


PARAMS = [(QQ(2) / 5, QQ(4) / 5), (QQ(6) / 5, QQ(3) / 10), (QQ(11) / 25, QQ(11) / 25), (QQ(1) / 10, QQ(2))]

count = 0
broken = 0
for M in range(2, 7):
    for (K1, K2) in PARAMS:
        gam = [gamma_tilde_b(M, mu, K1, K2) for mu in range(1, M + 1)]
        for g in gam:
            assert g >= 0                                   # def_gamma_theta: γ ∈ ℝ_{≥0}
            count += 1
        for eps in cartesian_product([[0, 1]] * M):
            x = gcheck(M, eps, gam)
            assert x.is_finite()                            # ǧ(ε) ∈ ℝ
            # 最後の段落: exp(ǧ(ε)) > 0
            assert x.exp() > 0, (M, K1, K2, eps)
            count += 1
            # real_exp_positive Step 1 の鎖（x := ǧ(ε)）
            lines1 = [x.exp() * (-x).exp(), (x + (-x)).exp(), RB(0).exp(), RB(1)]
            for a, b in zip(lines1, lines1[1:]):
                assert a.rad() < 1e-40 and b.rad() < 1e-40
                assert a.overlaps(b), ("step1", M, eps)
                count += 1
            if not x.contains_zero():
                bad1 = (x + x).exp()
                assert not lines1[0].overlaps(bad1) and not bad1.overlaps(lines1[2])
                broken += 1
            # real_exp_positive Step 2 の鎖（x := ǧ(ε)）
            h = x / 2
            lines2 = [x.exp(), (h + h).exp(), h.exp() * h.exp(), h.exp() ** 2]
            for a, b in zip(lines2, lines2[1:]):
                assert a.rad() < 1e-40 and b.rad() < 1e-40
                assert a.overlaps(b), ("step2", M, eps)
                count += 1
            if not x.contains_zero():
                bad2 = h.exp() * x.exp()
                assert not lines2[1].overlaps(bad2) and not bad2.overlaps(lines2[3])
                broken += 1
            assert h.exp() ** 2 >= 0
            count += 1

# 否定コントロール: ℤ 上の f(n) = (-1)^n
f = lambda n: (-1) ** n
for a in range(-5, 6):
    for b in range(-5, 6):
        assert f(a + b) == f(a) * f(b)
assert f(0) == 1
assert f(1) < 0
assert all(2 * y != 1 for y in range(-10, 11))              # 1 は ℤ の中で y + y の形に書けない
assert broken > 0

print("checked steps:", count)
print("negative controls (broken lines detected):", broken)
print("negative controls (Z counterexample): 1")
print("RESULT: PASS")
