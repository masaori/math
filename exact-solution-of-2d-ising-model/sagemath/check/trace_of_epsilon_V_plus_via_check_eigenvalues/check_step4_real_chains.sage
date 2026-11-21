# 対象ラベル: trace_of_epsilon_V_plus_via_check_eigenvalues（Step 4 の二つの鎖。w̌_μ^{(e)} := ǔ^{(e)}exp(γ(θ̃_μ)h(e))、h は def_half_sign_of_binary_value）
# 第一の鎖（各 ε。9 行）:
#   ť_ε = (Π_{μ∈M̌}ǔ^{(ε(μ))})Λ̌_ε                                    (ť_ε の置き方)
#       = (Π_{μ∈M̌}ǔ^{(ε(μ))})(C exp(Σ_{μ∈M̌}γ_μh(ε(μ))))              (eigenvalues_of_V_plus の Λ̌_ε)
#       = (Π_{μ=1}^{M}ǔ^{(ε(μ))})(C exp(Σ_{μ∈M̌}γ_μh(ε(μ))))           (def_product_over_check_index_set)
#       = (Π_{μ=1}^{M}ǔ^{(ε(μ))})(C exp(Σ_{μ=1}^{M}γ_μh(ε(μ))))        (def_sum_over_check_index_set)
#       = (Π_μǔ^{(ε(μ))})(C Π_μexp(γ_μh(ε(μ))))                         (real_exp_of_finite_sum)
#       = C((Π_μǔ^{(ε(μ))})Π_μexp(γ_μh(ε(μ))))                          (ℝ で a(bc) = b(ac))
#       = C Π_μ(ǔ^{(ε(μ))}exp(γ_μh(ε(μ))))                              (finite_product_of_real_products を右辺から左辺へ)
#       = C Π_μ w̌_μ^{(ε(μ))}                                             (w̌_μ^{(e)} の置き方)
#       = (Π_μ w̌_μ^{(ε(μ))}) C                                           (ℝ の乗法の交換律)
#   Π_{μ∈M̌}・Σ_{μ∈M̌} と Π_{μ=1}^{M}・Σ_{μ=1}^{M} は定義で同じ左からの畳み込みなので、2・3・4 行目は同じ式で組んだ値を並べる。
# 第二の鎖（15 行）: Σ_ε ť_ε = Σ_ε(Π w̌^{(ε(μ))})C = (Σ_ε Π w̌^{(ε(μ))})C = (Π(w̌^{(1)} + w̌^{(0)}))C
#   = (Π(ǔ^{(1)}exp(γh(1)) + ǔ^{(0)}exp(γh(0))))C = (Π(1·exp(γh(1)) + (−1)exp(γh(0))))C
#   = (Π(exp(γh(1)) + (−1)exp(γh(0))))C = (Π(exp(γh(1)) + (−exp(γh(0)))))C = (Π(exp(γh(1)) − exp(γh(0))))C
#   = (Π(exp(γ·1/2) − exp(γ(−(1/2)))))C = (Π(exp(γ·1/2) − exp(−(γ·1/2))))C
#   = (Π(exp(γ/2) − exp(−γ/2)))C = (Π 2·((exp(γ/2) − exp(−γ/2))/2))C = (Π 2sinh(γ/2))C = C Π 2sinh(γ/2) = ϰ
# C := (2sinh 2K_2)^{M/2} = (√(2sinh 2K_2))^{M}（def_second_transfer_matrix_prefactor）、γ_μ := γ(θ̃_μ)。ε の値 ε(μ) に算術はせず、h を通す。
# 球の部: γ(θ̃_μ)・exp・sinh・C の値は ℝ への脱出（arccosh の実対数・cos・cosh・sinh・tanh・exp・平方根の値）なので
#   RealBallField(512) の球で、各行を本文の書き方どおりに組み（和・積は定義どおり左から畳み込み、和は {0,1}^M の帰納法）、
#   隣どうしの行の球が重なり半径が 1e-100 未満であることを確かめる。sinh の行は Sage の sinh で計算し、def_cosh_sinh の式で
#   組んだ前の行と独立に比べる。結合定数は有理数の (K_1, K_2) の 4 組と、本文の ψ̌ の検算と同じ (2 log y, log x) の 3 組、M_col = 2..6。
# 厳密な部: 行の構造（有限積の分配、和の分配、展開）を γ によらず確かめるため、exp(γ_μ/2) を QQ 上のローラン多項式環の不定元 A_μ、
#   C を不定元に置き（exp(γh(e)) = A^{2h(e)}）、第一の鎖の 5〜9 行と第二の鎖の 1〜4 行と最後の閉形式 C·Π(A − A^{-1}) を厳密に比べる。
#   指数の引数の書き換え（h(1) = 1/2・h(0) = −(1/2)（def_half_sign_of_binary_value）、a(−b) = −(ab)（real_times_negation_is_negation_of_product）、a·1/2 = a/2（real_times_half_is_quotient_by_two））は QQ[γ]、1·b = b（乗法の単位元）・(−1)b = −b（real_minus_one_times_is_negation）・a + (−b) = a − b（def_real_difference）は QQ[a, b]、
#   b = 2·(b/2)（real_twice_quotient_by_two_is_original を右辺から左辺へ）は QQ(b) で恒等式として確かめる。
load("_prelude.sage")

fold_sum = lambda xs: left_product(xs, lambda x, y: x + y)
fold_prod = lambda xs: left_product(xs)
TOL = 1e-100


def same(x, y):
    assert x.rad() < TOL and y.rad() < TOL, (x.rad(), y.rad())
    return x.overlaps(y)


PARAMS = [(RB(QQ(2) / 5), RB(QQ(4) / 5)), (RB(QQ(6) / 5), RB(QQ(3) / 10)), (RB(QQ(11) / 25), RB(QQ(11) / 25)), (RB(QQ(1) / 10), RB(2))]
PARAMS += [(2 * RB(QQ(y)).log(), RB(QQ(x)).log()) for (x, y) in COUPLINGS]
half = RB(1) / 2
count = 0
negatives = 0
for (K1, K2) in PARAMS:
    for M in range(2, 7):
        gam = [gamma_tilde_ball(M, mu, K1, K2) for mu in range(1, M + 1)]
        C = (2 * (2 * K2).sinh()).sqrt() ** M
        words = list(itertools.product([1, 0], repeat=M))
        U = lambda w: RB(left_product([u_sign(e) for e in w]))
        hb = lambda e: RB(h_half(e))                                   # h(e) ∈ ℝ
        aa = lambda mu, e: RB(u_sign(e)) * (gam[mu] * hb(e)).exp()
        Lam = lambda w: C * fold_sum([gam[mu] * hb(w[mu]) for mu in range(M)]).exp()
        t = lambda w: U(w) * Lam(w)
        for w in words:
            L = [
                t(w),
                U(w) * Lam(w),
                U(w) * (C * fold_sum([gam[mu] * hb(w[mu]) for mu in range(M)]).exp()),
                U(w) * (C * fold_sum([gam[mu] * hb(w[mu]) for mu in range(M)]).exp()),
                U(w) * (C * fold_sum([gam[mu] * hb(w[mu]) for mu in range(M)]).exp()),
                U(w) * (C * fold_prod([(gam[mu] * hb(w[mu])).exp() for mu in range(M)])),
                C * (U(w) * fold_prod([(gam[mu] * hb(w[mu])).exp() for mu in range(M)])),
                C * fold_prod([RB(u_sign(w[mu])) * (gam[mu] * hb(w[mu])).exp() for mu in range(M)]),
                C * fold_prod([aa(mu, w[mu]) for mu in range(M)]),
                fold_prod([aa(mu, w[mu]) for mu in range(M)]) * C,
            ]
            for x, y in zip(L, L[1:]):
                assert same(x, y), (M, w)
                count += 1
        e1 = lambda mu: (gam[mu] * hb(1)).exp()
        e0 = lambda mu: (gam[mu] * hb(0)).exp()
        S = [
            binary_word_sum(M, t),
            binary_word_sum(M, lambda w: fold_prod([aa(mu, w[mu]) for mu in range(M)]) * C),
            binary_word_sum(M, lambda w: fold_prod([aa(mu, w[mu]) for mu in range(M)])) * C,
            fold_prod([aa(mu, 1) + aa(mu, 0) for mu in range(M)]) * C,
            fold_prod([RB(u_sign(1)) * e1(mu) + RB(u_sign(0)) * e0(mu) for mu in range(M)]) * C,
            fold_prod([1 * e1(mu) + (-1) * e0(mu) for mu in range(M)]) * C,
            fold_prod([e1(mu) + (-1) * e0(mu) for mu in range(M)]) * C,
            fold_prod([e1(mu) + (-e0(mu)) for mu in range(M)]) * C,
            fold_prod([e1(mu) - e0(mu) for mu in range(M)]) * C,
            fold_prod([(gam[mu] * half).exp() - (gam[mu] * (-half)).exp() for mu in range(M)]) * C,
            fold_prod([(gam[mu] * half).exp() - (-(gam[mu] * half)).exp() for mu in range(M)]) * C,
            fold_prod([(gam[mu] / 2).exp() - (-(gam[mu] / 2)).exp() for mu in range(M)]) * C,
            fold_prod([2 * (((gam[mu] / 2).exp() - (-(gam[mu] / 2)).exp()) / 2) for mu in range(M)]) * C,
            fold_prod([2 * (gam[mu] / 2).sinh() for mu in range(M)]) * C,
            C * fold_prod([2 * (gam[mu] / 2).sinh() for mu in range(M)]),
        ]
        for x, y in zip(S, S[1:]):
            assert same(x, y), M
            count += 1
        # 否定コントロール: ǔ^{(0)} を +1 にした和（Σ_ε Λ̌_ε）は ϰ と重ならない（cosh の積になる）
        assert not binary_word_sum(M, Lam).overlaps(S[-1])
        # 否定コントロール: sinh の引数の 1/2 を落とすと 13 行目と重ならない
        assert not (fold_prod([2 * gam[mu].sinh() for mu in range(M)]) * C).overlaps(S[12])
        # 否定コントロール: C を落とすと重ならない
        assert not fold_prod([2 * (gam[mu] / 2).sinh() for mu in range(M)]).overlaps(S[-1])
        negatives += 3

# 厳密な部
exact = 0
for M in range(1, 7):
    R = LaurentPolynomialRing(QQ, ["C"] + ["A%d" % mu for mu in range(1, M + 1)])
    Cx, A = R.gens()[0], R.gens()[1:]
    words = list(itertools.product([1, 0], repeat=M))
    ax = lambda mu, e: u_sign(e) * A[mu] ** two_h(e)
    for w in words:
        L = [
            R(left_product([u_sign(e) for e in w])) * (Cx * left_product([A[mu] ** two_h(w[mu]) for mu in range(M)])),
            Cx * (R(left_product([u_sign(e) for e in w])) * left_product([A[mu] ** two_h(w[mu]) for mu in range(M)])),
            Cx * left_product([u_sign(w[mu]) * A[mu] ** two_h(w[mu]) for mu in range(M)]),
            Cx * left_product([ax(mu, w[mu]) for mu in range(M)]),
            left_product([ax(mu, w[mu]) for mu in range(M)]) * Cx,
        ]
        for x, y in zip(L, L[1:]):
            assert x == y
            exact += 1
    S = [
        binary_word_sum(M, lambda w: left_product([ax(mu, w[mu]) for mu in range(M)]) * Cx),
        binary_word_sum(M, lambda w: left_product([ax(mu, w[mu]) for mu in range(M)])) * Cx,
        left_product([ax(mu, 1) + ax(mu, 0) for mu in range(M)]) * Cx,
        left_product([A[mu] - A[mu] ** -1 for mu in range(M)]) * Cx,
    ]
    for x, y in zip(S, S[1:]):
        assert x == y
        exact += 1
    # 否定コントロール: 展開で ǔ を落とすと外れる
    assert binary_word_sum(M, lambda w: left_product([A[mu] ** two_h(w[mu]) for mu in range(M)])) * Cx != S[-1]
    negatives += 1
P = PolynomialRing(QQ, 'gam')
g = P.gen()
h = QQ(1) / 2
assert h_half(1) == h and h_half(0) == -h                       # def_half_sign_of_binary_value
exact += 1
for x, y in [(g * h_half(1), g * h), (g * h_half(0), g * (-h)), (g * (-h), -(g * h)), (g * h, g / 2), (-(g * h), -(g / 2))]:
    assert x == y
    exact += 1
Pab = PolynomialRing(QQ, ['a', 'b'])
a_, b_ = Pab.gens()
assert 1 * b_ == b_
assert (-1) * b_ == -b_                 # real_minus_one_times_is_negation（a → b）
assert a_ + (-b_) == a_ - b_            # def_real_difference（y → a、z → b）を右辺から左辺へ
assert a_ + (-1) * b_ != a_ + b_        # 否定コントロール: (−1)b を b に取り違えると一致しない
exact += 3
negatives += 1
Fb = FractionField(PolynomialRing(QQ, 'b'))
assert Fb.gen() == 2 * (Fb.gen() / 2)
exact += 1
# 否定コントロール: h(0) を +1/2 に取り違えた書き換えは恒等式でない
assert g * h_half(0) != g * h
negatives += 1
print(f"checked {count} ball lines, {exact} exact lines")
print(f"negative controls: {negatives}")
print("RESULT: PASS")
