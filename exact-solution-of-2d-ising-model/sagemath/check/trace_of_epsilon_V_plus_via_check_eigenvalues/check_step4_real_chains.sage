# 対象ラベル: trace_of_epsilon_V_plus_via_check_eigenvalues（Step 4 の二つの鎖。w̌_μ^{(e)} := ǔ^{(e)}exp(γ(θ̃_μ)(e − 1/2))）
# 第一の鎖（各 ϵ。7 行）:
#   ť_ϵ = (Π_μǔ^{(ϵ_μ)})Λ̌_ϵ                               (ť_ϵ の置き方)
#       = (Π_μǔ^{(ϵ_μ)})(C exp(Σ_μγ_μ(ϵ_μ − 1/2)))         (eigenvalues_of_V_plus の Λ̌_ϵ)
#       = (Π_μǔ^{(ϵ_μ)})(C Π_μexp(γ_μ(ϵ_μ − 1/2)))          (real_exp_of_finite_sum)
#       = C((Π_μǔ^{(ϵ_μ)})Π_μexp(γ_μ(ϵ_μ − 1/2)))           (ℝ で a(bc) = b(ac))
#       = C Π_μ(ǔ^{(ϵ_μ)}exp(γ_μ(ϵ_μ − 1/2)))               (finite_product_of_real_products を右辺から左辺へ)
#       = C Π_μ w̌_μ^{(ϵ_μ)}                                  (w̌_μ^{(e)} の置き方)
#       = (Π_μ w̌_μ^{(ϵ_μ)}) C                                (ℝ の乗法の交換則)
# 第二の鎖（16 行）: Σ_ϵ ť_ϵ = Σ_ϵ(Π w̌^{(ϵ_μ)})C = (Σ_ϵ Π w̌^{(ϵ_μ)})C = (Π(w̌^{(1)} + w̌^{(0)}))C
#   = (Π(ǔ^{(1)}exp(γ(1−1/2)) + ǔ^{(0)}exp(γ(0−1/2))))C = (Π(1·exp(γ(1−1/2)) + (−1)exp(γ(0−1/2))))C
#   = (Π(exp(γ(1−1/2)) + (−1)exp(γ(0−1/2))))C = (Π(exp(γ(1−1/2)) − exp(γ(0−1/2))))C
#   = (Π(exp(γ·1/2) − exp(γ(0−1/2))))C = (Π(exp(γ·1/2) − exp(γ(−1/2))))C = (Π(exp(γ·1/2) − exp(−(γ·1/2))))C
#   = (Π(exp(γ/2) − exp(−γ/2)))C = (Π 2·((exp(γ/2) − exp(−γ/2))/2))C = (Π 2sinh(γ/2))C = C Π 2sinh(γ/2) = ϰ
# C := (2sinh 2K_2)^{M/2} = (√(2sinh 2K_2))^{M}（def_second_transfer_matrix_prefactor）、γ_μ := γ(θ̃_μ)。
# 球の部: γ(θ̃_μ)・exp・sinh・C の値は ℝ への脱出（arccosh の実対数・cos・cosh・sinh・tanh・exp・平方根の値）なので
#   RealBallField(512) の球で、各行を本文の書き方どおりに組み（和・積は定義どおり左から畳み込み、和は {0,1}^M の帰納法）、
#   隣どうしの行の球が重なり半径が 1e-100 未満であることを確かめる。sinh の行は Sage の sinh で計算し、def_cosh_sinh の式で
#   組んだ前の行と独立に比べる。結合定数は有理数の (K_1, K_2) の 4 組と、本文の ψ̌ の検算と同じ (2 log y, log x) の 3 組、M_col = 2..6。
# 厳密な部: 行の構造（有限積の分配、和の分配、展開）を γ によらず確かめるため、exp(γ_μ/2) を QQ 上のローラン多項式環の不定元 A_μ、
#   C を不定元に置き（exp(γ(e − 1/2)) = A^{2e−1}）、第一の鎖の 3〜6 行と第二の鎖の 1〜4 行と最後の閉形式 C·Π(A − A^{-1}) を厳密に比べる。
#   指数の引数の書き換え（1 − 1/2 = 1/2、0 − a = −a、a(−b) = −(ab)、a·1/2 = a/2）は QQ[γ]、1·b = b・a + (−1)b = a − b は QQ[a, b]、
#   b = 2·(b/2) は QQ(b) で恒等式として確かめる。
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
        aa = lambda mu, e: RB(u_sign(e)) * (gam[mu] * (RB(e) - half)).exp()
        Lam = lambda w: C * fold_sum([gam[mu] * (RB(w[mu]) - half) for mu in range(M)]).exp()
        t = lambda w: U(w) * Lam(w)
        for w in words:
            L = [
                t(w),
                U(w) * Lam(w),
                U(w) * (C * fold_sum([gam[mu] * (RB(w[mu]) - half) for mu in range(M)]).exp()),
                U(w) * (C * fold_prod([(gam[mu] * (RB(w[mu]) - half)).exp() for mu in range(M)])),
                C * (U(w) * fold_prod([(gam[mu] * (RB(w[mu]) - half)).exp() for mu in range(M)])),
                C * fold_prod([RB(u_sign(w[mu])) * (gam[mu] * (RB(w[mu]) - half)).exp() for mu in range(M)]),
                C * fold_prod([aa(mu, w[mu]) for mu in range(M)]),
                fold_prod([aa(mu, w[mu]) for mu in range(M)]) * C,
            ]
            for x, y in zip(L, L[1:]):
                assert same(x, y), (M, w)
                count += 1
        e1 = lambda mu: (gam[mu] * (1 - half)).exp()
        e0 = lambda mu: (gam[mu] * (0 - half)).exp()
        S = [
            binary_word_sum(M, t),
            binary_word_sum(M, lambda w: fold_prod([aa(mu, w[mu]) for mu in range(M)]) * C),
            binary_word_sum(M, lambda w: fold_prod([aa(mu, w[mu]) for mu in range(M)])) * C,
            fold_prod([aa(mu, 1) + aa(mu, 0) for mu in range(M)]) * C,
            fold_prod([RB(u_sign(1)) * e1(mu) + RB(u_sign(0)) * e0(mu) for mu in range(M)]) * C,
            fold_prod([1 * e1(mu) + (-1) * e0(mu) for mu in range(M)]) * C,
            fold_prod([e1(mu) + (-1) * e0(mu) for mu in range(M)]) * C,
            fold_prod([e1(mu) - e0(mu) for mu in range(M)]) * C,
            fold_prod([(gam[mu] * half).exp() - e0(mu) for mu in range(M)]) * C,
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
        # 否定コントロール: ǔ^{(0)} を +1 にした和（Σ_ϵ Λ̌_ϵ）は ϰ と重ならない（cosh の積になる）
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
    ax = lambda mu, e: u_sign(e) * A[mu] ** (2 * e - 1)
    for w in words:
        L = [
            R(left_product([u_sign(e) for e in w])) * (Cx * left_product([A[mu] ** (2 * w[mu] - 1) for mu in range(M)])),
            Cx * (R(left_product([u_sign(e) for e in w])) * left_product([A[mu] ** (2 * w[mu] - 1) for mu in range(M)])),
            Cx * left_product([u_sign(w[mu]) * A[mu] ** (2 * w[mu] - 1) for mu in range(M)]),
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
    assert binary_word_sum(M, lambda w: left_product([A[mu] ** (2 * w[mu] - 1) for mu in range(M)])) * Cx != S[-1]
    negatives += 1
P = PolynomialRing(QQ, 'gam')
g = P.gen()
h = QQ(1) / 2
for x, y in [(g * (1 - h), g * h), (g * (0 - h), g * (-h)), (g * (-h), -(g * h)), (g * h, g / 2), (-(g * h), -(g / 2))]:
    assert x == y
    exact += 1
Pab = PolynomialRing(QQ, ['a', 'b'])
a_, b_ = Pab.gens()
assert 1 * b_ == b_ and a_ + (-1) * b_ == a_ - b_
exact += 2
Fb = FractionField(PolynomialRing(QQ, 'b'))
assert Fb.gen() == 2 * (Fb.gen() / 2)
exact += 1
# 否定コントロール: 0 − 1/2 を +1/2 にした書き換えは恒等式でない
assert g * (0 - h) != g * h
negatives += 1
print(f"checked {count} ball lines, {exact} exact lines")
print(f"negative controls: {negatives}")
print("RESULT: PASS")
