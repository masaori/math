# 対象ラベル: trace_of_check_Vprime（Step 1 の 8 行の鎖）
# tr(V̌') = tr(V̌' I)                                   (identity_matrix_is_right_unit_of_mat_mult を右辺から左辺へ)
#        = tr(V̌' Σ_ε Q̌_ε)                             (check_joint_eigenspace_decomposition (2) を右辺から左辺へ)
#        = tr(Σ_ε V̌' Q̌_ε)                             (sum_over_binary_words_distributes_in_right_factor)
#        = Σ_ε tr(V̌' Q̌_ε)                             (trace_of_sum_over_binary_words)
#        = Σ_ε tr((exp ǧ(ε))_C Q̌_ε)                    (eigenvalues_of_check_Vprime を各項へ)
#        = Σ_ε (exp ǧ(ε))_C tr(Q̌_ε)                    (trace_of_scalar_multiple を各項へ)
#        = Σ_ε (exp ǧ(ε))_C 1_C                         (check_joint_eigenspace_decomposition (4) を各項へ)
#        = Σ_ε (exp ǧ(ε))_C                             (1_C は乗法の単位元を各項へ)
# 行列の和は def_sum_over_binary_words、複素数の和は def_sum_over_binary_words_of_complex_numbers の帰納法どおりに
# （最後の成分で 1 を 0 より先に）組む。積は mat_mult の成分の式（_shared の body_product）、スカラー倍は body_scalar、
# トレースは def_trace の対角成分の和で組む。
# ň_μ は Jordan–Wigner のフェルミ演算子 c_μ から ň_μ := c_μ^T c_μ で作る（check_48 と同じ。可換な冪等元で、Q̌_ε のトレースが 1）。
# Q̌_ε は R_μ^{(1)} := ň_μ、R_μ^{(0)} := I − ň_μ の左から掛ける積（check_48 で確かめた Q̌_ε = ∏R の形）。
# exp(γ(θ~_μ)/2) を有理関数体 QQ(a_1, …, a_M) の不定元 a_μ に置き、V̌' := ∏_μ (a_μ ň_μ + a_μ^{-1}(I − ň_μ))（左から掛ける積）とする。
# このとき exp(ǧ(ε)) = ∏_μ a_μ^{2ε_μ − 1} である。V̌' = exp(X̌) となること自体はここでは確かめていない
# （check_03・check_04 が数値で、eigenvalues_of_check_Vprime の検算が鎖で確かめている）。5 行目の V̌'Q̌_ε = exp(ǧ(ε))Q̌_ε は、
# この V̌' について、積として組んだ V̌'Q̌_ε と比べて確かめる。
# 帰属: QQ 上の有理関数体（厳密計算）。浮動小数点はない。
load("../../_shared/matrix_operations_by_definition.sage")
import itertools


def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def tr(A):
    """def_trace: 対角成分を k = 1, …, n の順に足す。"""
    total = A[0, 0]
    for k in range(1, A.nrows()):
        total = total + A[k, k]
    return total


def left_product(factors):
    """def_finite_product_of_matrices（左から掛ける）。"""
    P = factors[0]
    for A in factors[1:]:
        P = body_product(P, A)
    return P


def binary_word_matrix_sum(r, B):
    """def_sum_over_binary_words。"""
    if r == 1:
        return body_sum(B((1,)), B((0,)))
    return binary_word_matrix_sum(r - 1, lambda ep: body_sum(B(ep + (1,)), B(ep + (0,))))


def binary_word_complex_sum(r, z):
    """def_sum_over_binary_words_of_complex_numbers。"""
    if r == 1:
        return z((1,)) + z((0,))
    return binary_word_complex_sum(r - 1, lambda ep: z(ep + (1,)) + z(ep + (0,)))


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
    Q = {eps: left_product([Rf(mu, eps[mu]) for mu in range(M)]) for eps in itertools.product([1, 0], repeat=M)}
    V = left_product([body_sum(body_scalar(a[mu], n[mu]), body_scalar(a[mu] ** -1, Id - n[mu])) for mu in range(M)])
    expg = lambda eps: prod(a[mu] ** (2 * eps[mu] - 1) for mu in range(M))
    one = K(1)
    # 引いた主張の前提: (2) Σ_ε Q̌_ε = I、(4) tr(Q̌_ε) = 1、eigenvalues_of_check_Vprime の V̌'Q̌_ε = exp(ǧ(ε))Q̌_ε
    assert binary_word_matrix_sum(M, lambda eps: Q[eps]) == Id
    for eps in Q:
        assert tr(Q[eps]) == one
        assert body_product(V, Q[eps]) == body_scalar(expg(eps), Q[eps])
    lines = [
        tr(V),
        tr(body_product(V, Id)),
        tr(body_product(V, binary_word_matrix_sum(M, lambda eps: Q[eps]))),
        tr(binary_word_matrix_sum(M, lambda eps: body_product(V, Q[eps]))),
        binary_word_complex_sum(M, lambda eps: tr(body_product(V, Q[eps]))),
        binary_word_complex_sum(M, lambda eps: tr(body_scalar(expg(eps), Q[eps]))),
        binary_word_complex_sum(M, lambda eps: expg(eps) * tr(Q[eps])),
        binary_word_complex_sum(M, lambda eps: expg(eps) * one),
        binary_word_complex_sum(M, lambda eps: expg(eps)),
    ]
    for x, y in zip(lines, lines[1:]):
        assert x == y, M
        count += 1
    # 独立な経路: Sage の trace と、Π_μ (a_μ + a_μ^{-1})（Step 2 の閉形式 Π 2cosh(γ/2) の a による形）
    assert lines[0] == V.trace()
    assert lines[-1] == prod(a[mu] + a[mu] ** -1 for mu in range(M))
    # 否定コントロール: (4) の tr(Q̌_ε) = 1 の代わりに ň_μ の積のトレース（2^{M−k}）を使うと最後の行が外れる
    bad = binary_word_complex_sum(M, lambda eps: expg(eps) * tr(left_product([n[mu] for mu in range(M) if eps[mu] == 1] or [Id])))
    assert bad != lines[-1]
    negatives += 1
print(f"checked {count} lines")
print(f"negative controls: {negatives}")
print("RESULT: PASS")
