# 対象ラベル: trace_of_check_Vprime（Step 3 と Step 4 の実数の値の行）
# Step 3（γ_μ := γ(θ̃_μ)）:
#   Σ_ε exp(−ǧ(ε)) = Π_μ 2cosh(−γ_μ/2)      (Step 2 を γ ↦ −γ として。check_step3_chain.sage の鎖の右辺 Σ_ε (exp(−ǧ(ε)))_C の実数の値)
#   Π_μ 2cosh((−γ_μ)/2) = Π_μ 2cosh(−(γ_μ/2))   (ℝ で (−a)/2 = −(a/2)。この行は QQ[γ] でも厳密に確かめる)
#   Π_μ 2cosh(−(γ_μ/2)) = Π_μ 2cosh(γ_μ/2)    (cosh_is_even、x → γ_μ/2。各因子の cosh(−x) = cosh(x) も確かめる)
#   Π_μ 2cosh(γ_μ/2) = Σ_ε exp(ǧ(ε))        (Step 1〜2 の V̌' のトレース表示)
# Step 4:
#   γ_μ > 0                                  (gamma_theta_tilde_mu_positive)
#   2cosh(γ_μ/2) ≥ 2·1                       (cosh_at_least_one、x → γ_μ/2 の両辺に 2 > 0 を掛ける)
#   2·1 = 2、2 > 0
#   Π_μ 2cosh(γ_μ/2) > 0                     (正数の有限積は正。def_finite_product_of_real_numbers どおり左から畳み込み、各段の積が正であることを見る)
# ǧ(ε) は def_finite_sum_of_real_numbers どおり左から足し、{0,1}^{M_col} の上の和は def_sum_over_binary_words_of_real_numbers どおり組む。
# cosh は Sage の cosh で計算する（Σ_ε exp(±ǧ(ε)) は exp だけで組むので、両者の比較は独立な経路の比較になる）。
# 帰属: γ(θ̃_μ)・ǧ(ε)・exp・cosh は ℝ の元で、値は ℝ への脱出（log tanh・cosh・sinh・cos・arccosh・exp の値。いずれも極限で定まる）なので、
#   RealBallField(200) の球で扱う。等号は球の重なりと半径 < 10^{-40} で、不等号は球の全体が不等式を満たすことで確かめる。
# K_1, K_2 は有理数（check_step2_*.sage と同じ 4 組）、M_col = 2..6、全ての ε。
# 否定コントロール: (a) Step 3 の 1 行目の左辺を Σ_ε exp(−2ǧ(ε)) に壊すと右辺と重ならない。(b) cosh を sinh にすると
#   2sinh(−γ_μ/2) は 2 以上でなく、M_col が奇数なら Π_μ 2sinh(−γ_μ/2) は正でない。(c) 下界を 2 から 3 に上げた 2cosh(γ_μ/2) ≥ 3 は
#   成り立たない μ がある（球の全体が 3 より小さい。2 の下界が値に近い組があり、球の不等号が下界の違いを見分けること）。(d) (−γ)/2 ≠ γ/2。

RB = RealBallField(200)
pi_b = RB.pi()


def K_star_b(K):
    # 双対結合定数 K* := -(1/2) log(tanh K)（_shared/spin_ops.sage の K_star と同じ式）
    return -(RB(K).tanh().log()) / 2


def gamma_tilde_b(M, mu, K1, K2):
    # γ(θ~_μ) := arccosh(γ_1(θ~_μ))、γ_1(θ) = c_1c_2^* − s_1s_2^* cos θ、θ~_μ = 2π(μ − 1/2)/M
    K2s = K_star_b(K2)
    c1, s1 = (2 * RB(K1)).cosh(), (2 * RB(K1)).sinh()
    c2s, s2s = (2 * K2s).cosh(), (2 * K2s).sinh()
    th = 2 * pi_b * (RB(mu) - RB(1) / 2) / M
    g1 = c1 * c2s - s1 * s2s * th.cos()
    assert g1 >= 1, ("gamma_1 < 1", M, mu, K1, K2)
    return g1.arccosh()


def finite_sum(xs):
    s = xs[0]
    for x in xs[1:]:
        s = s + x
    return s


def finite_prod(ys):
    p = ys[0]
    for y in ys[1:]:
        p = p * y
    return p


def bsum(r, f):
    # def_sum_over_binary_words_of_real_numbers
    if r == 1:
        return f((1,)) + f((0,))
    return bsum(r - 1, lambda e: f(e + (1,)) + f(e + (0,)))


def same(a, b):
    assert a.rad() < 1e-40 and b.rad() < 1e-40
    return a.overlaps(b)


PARAMS = [(QQ(2) / 5, QQ(4) / 5), (QQ(6) / 5, QQ(3) / 10), (QQ(11) / 25, QQ(11) / 25), (QQ(1) / 10, QQ(2))]

# (−a)/2 = −(a/2) を QQ[γ] で厳密に
Pg = PolynomialRing(QQ, 'gam')
gg = Pg.gen()
assert (-gg) / 2 == -(gg / 2)
assert (-gg) / 2 != gg / 2                                              # 否定コントロール
step3 = 1
step4 = 0
neg = 1
loose = 0
half = RB(1) / 2
for M in range(2, 7):
    for (K1, K2) in PARAMS:
        g = [gamma_tilde_b(M, mu, K1, K2) for mu in range(1, M + 1)]
        gcheck = lambda eps: finite_sum([g[mu] * (RB(eps[mu]) - half) for mu in range(M)])
        # Step 3
        lines = [
            bsum(M, lambda eps: (-gcheck(eps)).exp()),
            finite_prod([2 * ((-g[mu]) / 2).cosh() for mu in range(M)]),
            finite_prod([2 * (-(g[mu] / 2)).cosh() for mu in range(M)]),
            finite_prod([2 * (g[mu] / 2).cosh() for mu in range(M)]),
            bsum(M, lambda eps: gcheck(eps).exp()),
        ]
        for x, y in zip(lines, lines[1:]):
            assert same(x, y), (M, K1, K2)
            step3 += 1
        for mu in range(M):
            assert same((-(g[mu] / 2)).cosh(), (g[mu] / 2).cosh()), (M, K1, K2, mu)
            step3 += 1
        bad = bsum(M, lambda eps: (-2 * gcheck(eps)).exp())
        assert not bad.overlaps(lines[1]), (M, K1, K2)
        neg += 1
        # Step 4
        assert RB(2) > 0
        partial = None
        for mu in range(M):
            assert g[mu] > 0, (M, K1, K2, mu)
            f = 2 * (g[mu] / 2).cosh()
            assert (g[mu] / 2).cosh() >= 1 and f >= 2 * RB(1) and 2 * RB(1) == 2 and f > 0, (M, K1, K2, mu)
            step4 += 4                                                  # γ > 0、cosh ≥ 1、2cosh ≥ 2·1、2cosh > 0 の 4 個（2·1 = 2 と 2 > 0 は μ に依らない）
            partial = f if partial is None else partial * f
            assert partial > 0, (M, K1, K2, mu)
            step4 += 1
            bad_f = 2 * (-g[mu] / 2).sinh()
            assert bad_f < 2, (M, K1, K2, mu)
            neg += 1
        assert same(partial, lines[3])
        if any(2 * (g[mu] / 2).cosh() < 3 for mu in range(M)):
            neg += 1
            loose += 1
        if M % 2 == 1:
            assert finite_prod([2 * (-g[mu] / 2).sinh() for mu in range(M)]) < 0
            neg += 1
print(f"checked {step3} Step 3 lines and {step4} Step 4 inequalities (M_col = 2..6, {len(PARAMS)} coupling pairs)")
assert loose > 0
print(f"negative controls: {neg}（うち 2cosh(γ/2) ≥ 3 が成り立たない組 {loose}）")
print("RESULT: PASS")
