# 対象ラベル: eigenvalues_of_inverse_of_check_Vprime（証明の 11 行の鎖）
# (V̌')^{-1}Q̌_ε = (V̌')^{-1}(1_C Q̌_ε)                                  (scalar_multiple_by_one を右辺から左辺へ)
#              = (V̌')^{-1}((exp 0)_C Q̌_ε)                             (scalar_exp_zero を右辺から左辺へ)
#              = (V̌')^{-1}((exp(−ǧ + ǧ))_C Q̌_ε)                       (ℝ で −a + a = 0 を右辺から左辺へ)
#              = (V̌')^{-1}((exp(−ǧ)exp(ǧ))_C Q̌_ε)                     (scalar_exp_product を右辺から左辺へ)
#              = (V̌')^{-1}(((exp(−ǧ))_C (exp ǧ)_C) Q̌_ε)               (real_inclusion_preserves_product を右辺から左辺へ)
#              = (V̌')^{-1}((exp(−ǧ))_C ((exp ǧ)_C Q̌_ε))               (scalar_multiple_is_associative を右辺から左辺へ)
#              = (exp(−ǧ))_C ((V̌')^{-1}((exp ǧ)_C Q̌_ε))               (scalar_multiple_factors_out_of_right_factor)
#              = (exp(−ǧ))_C ((V̌')^{-1}(V̌' Q̌_ε))                      (eigenvalues_of_check_Vprime を右辺から左辺へ)
#              = (exp(−ǧ))_C (((V̌')^{-1}V̌') Q̌_ε)                      (mat_mult_associative を右辺から左辺へ)
#              = (exp(−ǧ))_C (I Q̌_ε)                                  (def_invertible_elements_of_R の g^{-1}g = I)
#              = (exp(−ǧ))_C Q̌_ε                                      (identity_matrix_is_left_unit_of_mat_mult)
#
# 第 1 部（行列の行、厳密）: check_trace_of_check_Vprime_step1_chain と同じ置き方をする。ň_μ は Jordan–Wigner の
# c_μ から ň_μ := c_μ^T c_μ、Q̌_ε は R_μ^{(1)} := ň_μ、R_μ^{(0)} := I − ň_μ の左から掛ける積。exp(γ(θ~_μ)/2) を有理関数体
# QQ(a_1, …, a_M) の不定元 a_μ に置き、V̌' := ∏_μ (a_μň_μ + a_μ^{-1}(I − ň_μ))、(V̌')^{-1} := ∏_μ (a_μ^{-1}ň_μ + a_μ(I − ň_μ))
# とする。V̌' = exp(X̌) そのものはここでは確かめない（check_03・check_04 と eigenvalues_of_check_Vprime の検算が確かめている）。
# 実数 x = Σ_μ k_μ γ(θ~_μ)/2（k_μ ∈ ZZ）を係数の組 (k_1, …, k_M) で持ち、exp(x) := ∏_μ a_μ^{k_μ} とする。このとき
# ǧ(ε) は k_μ = 2ε_μ − 1、0 は k = 0、−a + a は係数の組の和である。引いた主張の前提（V̌'Q̌_ε = exp(ǧ(ε))Q̌_ε と
# (V̌')^{-1}V̌' = I）も確かめる。積は mat_mult の成分の式（_shared の body_product）、スカラー倍は body_scalar で組む。
# 第 2 部（ℝ の行、球）: 2〜4 行目の exp の値の行を、ǧ(ε) を def_gamma_theta の値で RealBallField(200) の球に置いて確かめる
# （ℝ への脱出: arccosh・exp・cos の値）。
# 第 1 部の 2〜6 行目（1_C、exp 0、exp(−ǧ+ǧ)、exp(−ǧ)exp ǧ、包含の積）は、この置き方では指数の組の整数の足し算と
# K の中の恒等に縮むので、ほぼ同語反復である。実質の比較は 7〜12 行目（スカラー倍の結合・外出し・固有関係・結合律・
# 逆元・単位行列）と、第 2 部の球の 3 行である。
# 否定コントロール: (a) 右辺の係数を exp(+ǧ(ε)) にすると外れること。この置き方では a_μ が独立な不定元で ǧ(ε) の係数は
# 全て ±1 なので、全ての ε で外れる（実際の γ では γ_{M+1−μ} = γ_μ のため ǧ(ε) = 0 になる ε があり、そこでは外れない）。
# (b) 鎖の行を壊すと隣の行と外れること: 9 行目の V̌'Q̌_ε を Q̌_ε に、11 行目の (V̌')^{-1}V̌' を V̌'V̌' に替える。
load("../../_shared/matrix_operations_by_definition.sage")
import itertools


def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def left_product(factors):
    """def_finite_product_of_matrices（左から掛ける）。"""
    P = factors[0]
    for A in factors[1:]:
        P = body_product(P, A)
    return P


count = 0
negatives = 0
for M in range(2, 5):
    K = FractionField(PolynomialRing(QQ, ["a%d" % mu for mu in range(1, M + 1)]))
    a = K.gens()
    sz = matrix(K, [[1, 0], [0, -1]])
    lower = matrix(K, [[0, 1], [0, 0]])
    id2 = identity_matrix(K, 2)
    Id = body_identity(K, 2 ** M)
    c = [kron([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    n = [c[mu].transpose() * c[mu] for mu in range(M)]
    Rf = lambda mu, e: n[mu] if e == 1 else Id - n[mu]
    V = left_product([body_sum(body_scalar(a[mu], n[mu]), body_scalar(a[mu] ** -1, Id - n[mu])) for mu in range(M)])
    Vinv = left_product([body_sum(body_scalar(a[mu] ** -1, n[mu]), body_scalar(a[mu], Id - n[mu])) for mu in range(M)])
    expv = lambda k: prod(a[mu] ** k[mu] for mu in range(M))      # exp(Σ k_μ γ_μ/2)
    neg = lambda k: tuple(-x for x in k)
    add = lambda k, l: tuple(x + y for x, y in zip(k, l))
    zero = tuple([0] * M)
    one = K(1)
    # 前提: (V̌')^{-1}V̌' = I（def_invertible_elements_of_R の g^{-1}g = I）
    assert body_product(Vinv, V) == Id
    for eps in itertools.product([1, 0], repeat=M):
        Q = left_product([Rf(mu, eps[mu]) for mu in range(M)])
        g = tuple(2 * e - 1 for e in eps)                          # ǧ(ε) の係数の組
        # 前提: eigenvalues_of_check_Vprime の V̌'Q̌_ε = (exp ǧ(ε))_C Q̌_ε
        assert body_product(V, Q) == body_scalar(expv(g), Q)
        lines = [
            body_product(Vinv, Q),
            body_product(Vinv, body_scalar(one, Q)),
            body_product(Vinv, body_scalar(expv(zero), Q)),
            body_product(Vinv, body_scalar(expv(add(neg(g), g)), Q)),
            body_product(Vinv, body_scalar(expv(neg(g)) * expv(g), Q)),
            body_product(Vinv, body_scalar(expv(neg(g)) * expv(g), Q)),   # ℂ の積で組む（包含は K の中で恒等）
            body_product(Vinv, body_scalar(expv(neg(g)), body_scalar(expv(g), Q))),
            body_scalar(expv(neg(g)), body_product(Vinv, body_scalar(expv(g), Q))),
            body_scalar(expv(neg(g)), body_product(Vinv, body_product(V, Q))),
            body_scalar(expv(neg(g)), body_product(body_product(Vinv, V), Q)),
            body_scalar(expv(neg(g)), body_product(Id, Q)),
            body_scalar(expv(neg(g)), Q),
        ]
        for x, y in zip(lines, lines[1:]):
            assert x == y, (M, eps)
            count += 1
        # 独立な経路: Sage の行列の積と逆行列
        assert lines[0] == V.inverse() * Q
        # 否定コントロール (a): 右辺を exp(+ǧ(ε)) にすると外れる
        assert body_scalar(expv(g), Q) != lines[0]
        negatives += 1
        # 否定コントロール (b): 鎖の行を壊すと隣の行と外れる
        assert body_scalar(expv(neg(g)), body_product(Vinv, Q)) != lines[7]
        negatives += 1
        assert body_scalar(expv(neg(g)), body_product(body_product(V, V), Q)) != lines[8]
        negatives += 1
print(f"checked {count} matrix lines (M_col = 2..4, all ε)")

# 第 2 部: ℝ の行（球）
RB = RealBallField(200)
pi_b = RB.pi()


def K_star_b(K):
    return -(RB(K).tanh().log()) / 2


def gamma_tilde_b(M, mu, K1, K2):
    K2s = K_star_b(K2)
    c1, s1 = (2 * RB(K1)).cosh(), (2 * RB(K1)).sinh()
    c2s, s2s = (2 * K2s).cosh(), (2 * K2s).sinh()
    th = 2 * pi_b * (RB(mu) - RB(1) / 2) / M
    g1 = c1 * c2s - s1 * s2s * th.cos()
    assert g1 >= 1
    return g1.arccosh()


def same(x, y):
    assert x.rad() < 1e-40 and y.rad() < 1e-40
    return x.overlaps(y)


PARAMS = [(QQ(2) / 5, QQ(4) / 5), (QQ(6) / 5, QQ(3) / 10), (QQ(11) / 25, QQ(11) / 25), (QQ(1) / 10, QQ(2))]
ball = 0
for M in range(2, 7):
    for (K1, K2) in PARAMS:
        gam = [gamma_tilde_b(M, mu, K1, K2) for mu in range(1, M + 1)]
        for eps in cartesian_product([[0, 1]] * M):
            gv = sum((gam[mu] * (RB(eps[mu]) - RB(1) / 2) for mu in range(M)), RB(0))
            vals = [RB(1), RB(0).exp(), (-gv + gv).exp(), (-gv).exp() * gv.exp()]
            for x, y in zip(vals, vals[1:]):
                assert same(x, y), (M, K1, K2, eps)
                ball += 1
print(f"checked {ball} real lines with balls (M_col = 2..6, 4 coupling pairs)")
print(f"negative controls: {negatives}")
print("RESULT: PASS")
