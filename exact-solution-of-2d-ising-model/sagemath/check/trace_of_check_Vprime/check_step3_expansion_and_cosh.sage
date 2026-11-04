# 対象ラベル: trace_of_check_Vprime（Step 3 のトレースの鎖の 10〜19 行目。γ_μ := γ(θ~_μ)、全体に (·)_ℂ が付く）
#   Σ_ε exp(−ǧ(ε))
#   = Σ_ε Π_μ exp((−γ_μ)(ε_μ − 1/2))                       (冒頭の exp(−ǧ(ε)) の鎖を各項へ同時に)
#   = Π_μ (exp((−γ_μ)(1 − 1/2)) + exp((−γ_μ)(0 − 1/2)))    (expansion_of_finite_product_of_two_term_sums_of_real_numbers を右辺から左辺へ)
#   = Π_μ (exp((−γ_μ)·1/2) + exp((−γ_μ)(0 − 1/2)))         (ℝ で 1 − 1/2 = 1/2)
#   = Π_μ (exp((−γ_μ)·1/2) + exp((−γ_μ)(−1/2)))            (ℝ で 0 − a = −a、a → 1/2)
#   = Π_μ (exp((−γ_μ)·1/2) + exp(−((−γ_μ)·1/2)))           (ℝ で a(−b) = −(ab)、a → −γ_μ、b → 1/2)
#   = Π_μ (exp((−γ_μ)/2) + exp(−((−γ_μ)/2)))               (ℝ で a·1/2 = a/2、a → −γ_μ、各因子の 2 箇所)
#   = Π_μ 2·((exp((−γ_μ)/2) + exp(−((−γ_μ)/2)))/2)         (ℝ で 2 ≠ 0 なので b = 2·(b/2))
#   = Π_μ 2cosh((−γ_μ)/2)                                  (def_cosh_sinh の cosh、x → (−γ_μ)/2、右辺から左辺へ)
#   = Π_μ 2cosh(−(γ_μ/2))                                  (ℝ で (−a)/2 = −(a/2))
#   = Π_μ 2cosh(γ_μ/2)                                     (cosh_is_even、x → γ_μ/2)
# 最後の 2 行は check_step3_and_step4_real_lines.sage も確かめている。ここでは鎖が切れずにつながることを見るために含める。
# 厳密な部: 展開の行を exp((−γ_μ)(e − 1/2)) → a_μ^{−(2e−1)}（a_μ は QQ 上の有理関数体の不定元）に置いて M_col = 1..6 で、
#   書き換えの 5 段（a·1/2 = a/2 は 2 箇所を別々に数えて 6 段）と (−a)/2 = −(a/2) を QQ[γ] の不定元で、b = 2·(b/2) を QQ(b) で確かめる。
# 球の部: γ(θ~_μ)・exp・cosh の値は ℝ への脱出なので、区間演算 RealBallField(200) の球で扱い、
#   11 個の式を M_col = 2..6、K の 4 組で組んで、隣どうしの球が交わること（半径 1e-40 未満）を確かめる。
#   1 行目の左辺の exp(−ǧ(ε)) は ǧ の定義の和の符号反転の exp として組み、2 行目の積とは別に計算する。
#   {0,1}^{M_col} の上の和は def_sum_over_binary_words_of_real_numbers どおり、有限和・有限積は左から畳み込む。
# 否定コントロール: 0 − 1/2 を +1/2 にした因子、cosh の引数の 1/2 を落とした因子、2 を落とした因子、
#   語を一つ落とした和が、球の部で 3 行目の積と交わらないことを確かめる。厳密な部では、因子を a_μ・a_μ^2 に替えた展開が一致しないことを見る。

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


def finite_prod(ys):
    p = ys[0]
    for y in ys[1:]:
        p = p * y
    return p


def same(a, b):
    assert a.rad() < 1e-40 and b.rad() < 1e-40
    return a.overlaps(b)


PARAMS = [(QQ(2) / 5, QQ(4) / 5), (QQ(6) / 5, QQ(3) / 10), (QQ(11) / 25, QQ(11) / 25), (QQ(1) / 10, QQ(2))]


def finite_sum(xs):
    s = xs[0]
    for x in xs[1:]:
        s = s + x
    return s


def bsum(r, f):
    # def_sum_over_binary_words_of_real_numbers
    if r == 1:
        return f((1,)) + f((0,))
    return bsum(r - 1, lambda e: f(e + (1,)) + f(e + (0,)))


# 厳密な部
exact = 0
P = PolynomialRing(QQ, 'gam')
gam = P.gen()
h = QQ(1) / 2
mg = -gam
exact_steps = [
    (mg * (1 - h), mg * h),            # 1 − 1/2 = 1/2
    (mg * (0 - h), mg * (-h)),         # 0 − a = −a
    (mg * (-h), -(mg * h)),            # a(−b) = −(ab)、a → −γ
    (mg * h, mg / 2),                  # a·1/2 = a/2（1 つ目の箇所）
    (-(mg * h), -(mg / 2)),            # a·1/2 = a/2（2 つ目の箇所）
    (mg / 2, -(gam / 2)),              # (−a)/2 = −(a/2)
]
for a, b in exact_steps:
    assert a == b
    exact += 1
Fb = FractionField(PolynomialRing(QQ, 'b'))
bb = Fb.gen()
assert bb == 2 * (bb / 2)              # b = 2·(b/2)
exact += 1
exact_broken = 0
for a, b in [(mg * (0 - h), mg * h), (mg * h, mg), (bb, bb / 2)]:
    if a != b:
        exact_broken += 1
assert exact_broken == 3
for M in range(1, 7):
    F = FractionField(PolynomialRing(QQ, [f'a{mu}' for mu in range(1, M + 1)]))
    av = F.gens()
    term = lambda mu, e: av[mu] ** (-(2 * e - 1))                 # exp((−γ_μ)(e − 1/2)) の置き方
    lhs = bsum(M, lambda eps: finite_prod([term(mu, eps[mu]) for mu in range(M)]))
    rhs = finite_prod([term(mu, 1) + term(mu, 0) for mu in range(M)])
    assert lhs == rhs, M
    exact += 1
    words = [tuple(w) for w in cartesian_product([[0, 1]] * M)]
    bad = sum(finite_prod([av[mu] ** (1 + w[mu]) for mu in range(M)]) for w in words[1:])
    assert bad != finite_prod([av[mu] ** 2 + av[mu] for mu in range(M)])
    exact_broken += 1

# 球の部
count = 0
broken = 0
half = RB(1) / 2
for M in range(2, 7):
    for (K1, K2) in PARAMS:
        g = [gamma_tilde_b(M, mu, K1, K2) for mu in range(1, M + 1)]
        exp_neg_g = lambda eps: (-finite_sum([g[m] * (RB(eps[m]) - half) for m in range(M)])).exp()
        prod_e = lambda eps: finite_prod([((-g[m]) * (RB(eps[m]) - half)).exp() for m in range(M)])
        lines = [
            bsum(M, exp_neg_g),
            bsum(M, prod_e),
            finite_prod([((-g[m]) * (RB(1) - half)).exp() + ((-g[m]) * (RB(0) - half)).exp() for m in range(M)]),
            finite_prod([((-g[m]) * half).exp() + ((-g[m]) * (RB(0) - half)).exp() for m in range(M)]),
            finite_prod([((-g[m]) * half).exp() + ((-g[m]) * (-half)).exp() for m in range(M)]),
            finite_prod([((-g[m]) * half).exp() + (-((-g[m]) * half)).exp() for m in range(M)]),
            finite_prod([((-g[m]) / 2).exp() + (-((-g[m]) / 2)).exp() for m in range(M)]),
            finite_prod([2 * ((((-g[m]) / 2).exp() + (-((-g[m]) / 2)).exp()) / 2) for m in range(M)]),
            finite_prod([2 * ((-g[m]) / 2).cosh() for m in range(M)]),
            finite_prod([2 * (-(g[m] / 2)).cosh() for m in range(M)]),
            finite_prod([2 * (g[m] / 2).cosh() for m in range(M)]),
        ]
        for a, b in zip(lines, lines[1:]):
            assert same(a, b), (M, K1, K2)
            count += 1
        words = [tuple(w) for w in cartesian_product([[0, 1]] * M)]
        bad = [
            finite_prod([((-g[m]) * half).exp() + ((-g[m]) * half).exp() for m in range(M)]),
            finite_prod([2 * (-g[m]).cosh() for m in range(M)]),
            finite_prod([((-g[m]) / 2).cosh() for m in range(M)]),
            sum(prod_e(w) for w in words[1:]),
        ]
        for x in bad:
            if not same(x, lines[2]):
                broken += 1
assert broken == 4 * 5 * len(PARAMS)
print(f"checked {exact} lines exactly (rewriting steps in QQ[γ] and QQ(b), expansion line for M_col = 1..6)")
print(f"exact negative controls detected: {exact_broken}")
print(f"checked {count} lines with balls (M_col = 2..6, {len(PARAMS)} coupling pairs)")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
