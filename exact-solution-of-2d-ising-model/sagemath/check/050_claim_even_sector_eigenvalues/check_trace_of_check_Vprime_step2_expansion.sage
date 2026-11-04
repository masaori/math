# 対象ラベル: trace_of_check_Vprime（Step 2 の展開の行と、それに続く 2 行）
#   Σ_ε exp(ǧ(ε)) = Σ_ε Π_μ exp(γ(θ~_μ)(ε_μ − 1/2))                       (直前の鎖を各項へ同時に)
#                 = Π_μ (exp(γ(θ~_μ)(1 − 1/2)) + exp(γ(θ~_μ)(0 − 1/2)))   (expansion_of_finite_product_of_two_term_sums_of_real_numbers
#                                                                           を右辺から左辺へ、a_μ^(e) → exp(γ(θ~_μ)(e − 1/2)))
#                 = Π_μ (exp(−γ(θ~_μ)/2) + exp(+γ(θ~_μ)/2))                (1 − 1/2 = 1/2、0 − 1/2 = −1/2 と和の交換則)
#                 = Π_μ 2cosh(γ(θ~_μ)/2)                                    (cosh x = (exp x + exp(−x))/2)
# 帰属: γ(θ~_μ)・ǧ(ε)・exp・cosh は ℝ の元で、値は ℝ への脱出（arccosh・exp・cos・cosh の値）なので、
# 区間演算 RealBallField(200) の球で扱う。等号の行は球が共通部分を持つこと（overlaps）と、半径が 1e-40 未満であることで確かめる。
# K_1, K_2 は有理数で与える。M_col = 2..6、K の 4 組。
# {0,1}^{M_col} の上の和は def_sum_over_binary_words_of_real_numbers どおり（最後の成分で 1 を 0 より先に足す帰納法）、
# 有限和・有限積は def_finite_sum_of_real_numbers・def_finite_product_of_real_numbers どおり左から畳み込む。
# 1 行目の左辺の exp(ǧ(ε)) は ǧ の定義の和の exp として組み、右辺の積（直前の鎖の右辺）とは別に計算する。
# 否定コントロール: 語を一つ落とした和は 3 行目の積と交わらないことを確かめる。
# 厳密な部: 展開の行（2 行目と 3 行目）を、exp(γ(θ~_μ)(e − 1/2)) を a_μ^{2e−1}（a_μ は QQ 上の有理関数体の不定元。
# Step 1 の検算と同じ置き方）に置いて M_col = 1..6 で厳密に確かめる。否定コントロールとして、因子の
# a^(1)・a^(0) を a_μ・a_μ^2 に替えると、語を一つ落とした和が積と一致しないことを見る。

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


def bsum(r, f):
    # def_sum_over_binary_words_of_real_numbers
    if r == 1:
        return f((1,)) + f((0,))
    return bsum(r - 1, lambda e: f(e + (1,)) + f(e + (0,)))


count = 0
broken = 0
half = RB(1) / 2
for M in range(2, 7):
    for (K1, K2) in PARAMS:
        gam = [gamma_tilde_b(M, mu, K1, K2) for mu in range(1, M + 1)]
        exp_g = lambda eps: finite_sum([gam[mu] * (RB(eps[mu]) - half) for mu in range(M)]).exp()
        prod_e = lambda eps: finite_prod([(gam[mu] * (RB(eps[mu]) - half)).exp() for mu in range(M)])
        lines = [
            bsum(M, exp_g),
            bsum(M, prod_e),
            finite_prod([(gam[mu] * (RB(1) - half)).exp() + (gam[mu] * (RB(0) - half)).exp() for mu in range(M)]),
            finite_prod([(-gam[mu] / 2).exp() + (gam[mu] / 2).exp() for mu in range(M)]),
            finite_prod([2 * (gam[mu] / 2).cosh() for mu in range(M)]),
        ]
        for a, b in zip(lines, lines[1:]):
            assert same(a, b), (M, K1, K2)
            count += 1
        words = [tuple(w) for w in cartesian_product([[0, 1]] * M)]
        bad = sum(prod_e(w) for w in words[1:])
        if not same(bad, lines[2]):
            broken += 1
assert broken == 5 * len(PARAMS)
exact = 0
for M in range(1, 7):
    F = FractionField(PolynomialRing(QQ, [f'a{mu}' for mu in range(1, M + 1)]))
    av = F.gens()
    term = lambda mu, e: av[mu] ** (2 * e - 1)                    # exp(γ(θ~_μ)(e − 1/2)) の置き方
    lhs = bsum(M, lambda eps: finite_prod([term(mu, eps[mu]) for mu in range(M)]))
    rhs = finite_prod([term(mu, 1) + term(mu, 0) for mu in range(M)])
    assert lhs == rhs, M
    exact += 1
    words = [tuple(w) for w in cartesian_product([[0, 1]] * M)]
    bad = sum(finite_prod([av[mu] ** (1 + w[mu]) for mu in range(M)]) for w in words[1:])
    assert bad != finite_prod([av[mu] ** 2 + av[mu] for mu in range(M)])
print(f"checked {count} lines (M_col = 2..6, {len(PARAMS)} coupling pairs)")
print(f"checked the expansion line exactly in {exact} cases (M_col = 1..6)")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
