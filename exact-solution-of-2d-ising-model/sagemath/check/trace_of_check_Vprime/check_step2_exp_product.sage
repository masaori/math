# 対象ラベル: trace_of_check_Vprime（Step 2 の指数法則の 3 行の鎖）
#   exp(ǧ(ε)) = exp(Σ_{μ∈M̌} γ(θ~_μ)h(ε(μ)))                (eigenvalues_of_check_Vprime の ǧ の定義)
#             = exp(Σ_{μ=1}^{M_col} γ(θ~_μ)h(ε(μ)))         (def_sum_over_check_index_set。作り方で自明: 同じ左からの和で組む)
#             = Π_{μ=1}^{M_col} exp(γ(θ~_μ)h(ε(μ)))          (real_exp_of_finite_sum, m → M_col, x_μ → γ(θ~_μ)h(ε(μ)))
# h は def_half_sign_of_binary_value の h(1) := ½、h(0) := −(½)。ε(μ) は算術に使わず h を通す。
# 帰属: γ(θ~_μ)・ǧ(ε)・exp は ℝ の元で、値は ℝ への脱出（arccosh・exp・cos の値）なので、
# 区間演算 RealBallField(200) の球で扱う。等号の行は球が共通部分を持つこと（overlaps）と、半径が 1e-40 未満であることで確かめる。
# K_1, K_2 は有理数で与える。M_col = 2..6、K の 4 組、全ての ε ∈ {0,1}^{M_col}。
# 有限和・有限積は def_finite_sum_of_real_numbers・def_finite_product_of_real_numbers どおり左から畳み込む。
# 比べる側: 右辺の積は Step 1・Step 2 の 1 行目の検算の置き方 Π_μ a_μ^{±1}（ε(μ) = 1 なら a_μ、0 なら a_μ^{-1}。a_μ = exp(γ(θ~_μ)/2)）に一致する。
# 否定コントロール: 3 行目の積を和 Σ_μ exp(γ(θ~_μ)h(ε(μ))) に壊すと 1 行目と交わらないことを確かめる。

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


def same(a, b):
    assert a.rad() < 1e-40 and b.rad() < 1e-40
    return a.overlaps(b)


PARAMS = [(QQ(2) / 5, QQ(4) / 5), (QQ(6) / 5, QQ(3) / 10), (QQ(11) / 25, QQ(11) / 25), (QQ(1) / 10, QQ(2))]

count = 0
broken = 0
for M in range(2, 7):
    for (K1, K2) in PARAMS:
        gam = [gamma_tilde_b(M, mu, K1, K2) for mu in range(1, M + 1)]
        for eps in cartesian_product([[0, 1]] * M):
            h = lambda e: RB(1) / 2 if e == 1 else -(RB(1) / 2)          # def_half_sign_of_binary_value
            terms = [gam[mu] * h(eps[mu]) for mu in range(M)]
            gcheck = finite_sum(terms)                                  # 主張の ǧ の定義（Σ_{μ∈M̌}）
            lines = [
                gcheck.exp(),
                finite_sum(terms).exp(),                                # ǧ の定義（Σ_{μ∈M̌}）
                finite_sum(terms).exp(),                                # Σ_{μ=1}^{M_col}（def_sum_over_check_index_set）
                finite_prod([t.exp() for t in terms]),
            ]
            for a, b in zip(lines, lines[1:]):
                assert same(a, b), (M, K1, K2, eps)
                count += 1
            # 比べる側: Π_μ a_μ^{±1}、a_μ = exp(γ(θ~_μ)/2)
            other = finite_prod([(gam[mu] / 2).exp() if eps[mu] == 1 else (gam[mu] / 2).exp() ** (-1) for mu in range(M)])
            assert same(lines[2], other)
            bad = finite_sum([t.exp() for t in terms])
            if not same(bad, lines[0]):
                broken += 1
assert broken > 0
print(f"checked {count} lines")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
