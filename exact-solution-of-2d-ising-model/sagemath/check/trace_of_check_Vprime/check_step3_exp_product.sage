# 対象ラベル: trace_of_check_Vprime（Step 3 の冒頭の 4 行の鎖）
#   exp(−ǧ(ε)) = exp(−Σ_{μ=1}^{M_col} γ(θ~_μ)(ε_μ − 1/2))          (eigenvalues_of_check_Vprime の ǧ の定義)
#              = exp(Σ_{μ=1}^{M_col} −(γ(θ~_μ)(ε_μ − 1/2)))         (finite_sum_of_negated_real_numbers を右辺から左辺へ)
#              = exp(Σ_{μ=1}^{M_col} (−γ(θ~_μ))(ε_μ − 1/2))         (ℝ で −(ab) = (−a)b を各項へ同時に)
#              = Π_{μ=1}^{M_col} exp((−γ(θ~_μ))(ε_μ − 1/2))          (real_exp_of_finite_sum)
# 帰属: γ(θ~_μ)・ǧ(ε)・exp は ℝ の元で、値は ℝ への脱出（arccosh・exp・cos の値）なので、
# 区間演算 RealBallField(200) の球で扱う。等号の行は球が共通部分を持つこと（overlaps）と、半径が 1e-40 未満であることで確かめる。
# K_1, K_2 は有理数で与える。M_col = 2..6、K の 4 組、全ての ε ∈ {0,1}^{M_col}。
# 有限和・有限積は def_finite_sum_of_real_numbers・def_finite_product_of_real_numbers どおり左から畳み込む。
# 厳密な部: 2 行目と 3 行目の指数の引数（有限和の符号反転と −(ab) = (−a)b）を、γ_μ を QQ 上の多項式環の不定元に置いて
#   M_col = 1..6、全ての ε で厳密に確かめる（1 行目は ǧ の定義なので同じ和から組む同語反復）。
# 比べる側: 右辺の積は Step 3 のトレースの鎖の検算（check_step3_chain.sage）の置き方 Π_μ a_μ^{−(2ε_μ − 1)}（a_μ = exp(γ(θ~_μ)/2)）に一致する。
# 否定コントロール: 符号反転を最後の項にだけ付け忘れた和（Σ_{μ<M} −(…) + γ_M(ε_M − 1/2)）の exp は 1 行目と交わらない。

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
            terms = [gam[mu] * (RB(eps[mu]) - RB(1) / 2) for mu in range(M)]
            gcheck = finite_sum(terms)                                  # 主張の ǧ の定義
            lines = [
                (-gcheck).exp(),
                (-finite_sum(terms)).exp(),
                finite_sum([-t for t in terms]).exp(),
                finite_sum([(-gam[mu]) * (RB(eps[mu]) - RB(1) / 2) for mu in range(M)]).exp(),
                finite_prod([((-gam[mu]) * (RB(eps[mu]) - RB(1) / 2)).exp() for mu in range(M)]),
            ]
            for a, b in zip(lines, lines[1:]):
                assert same(a, b), (M, K1, K2, eps)
                count += 1
            # 比べる側: Π_μ a_μ^{−(2ε_μ − 1)}、a_μ = exp(γ(θ~_μ)/2)
            other = finite_prod([(gam[mu] / 2).exp() ** (-(2 * eps[mu] - 1)) for mu in range(M)])
            assert same(lines[-1], other)
            bad = finite_sum([-t for t in terms[:-1]] + [terms[-1]]).exp()
            if not same(bad, lines[0]):
                broken += 1
assert broken == sum(len(PARAMS) * 2 ** M for M in range(2, 7))
exact = 0
for M in range(1, 7):
    Pg = PolynomialRing(QQ, [f"g{mu}" for mu in range(1, M + 1)])
    gv = Pg.gens()
    h = QQ(1) / 2
    for eps in cartesian_product([[0, 1]] * M):
        terms = [gv[mu] * (eps[mu] - h) for mu in range(M)]
        args = [
            -finite_sum(terms),
            finite_sum([-t for t in terms]),
            finite_sum([(-gv[mu]) * (eps[mu] - h) for mu in range(M)]),
        ]
        for a, b in zip(args, args[1:]):
            assert a == b, (M, eps)
            exact += 1
print(f"checked {count} lines with balls (M_col = 2..6, {len(PARAMS)} coupling pairs, all ε)")
print(f"checked {exact} argument lines exactly (M_col = 1..6, all ε)")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
