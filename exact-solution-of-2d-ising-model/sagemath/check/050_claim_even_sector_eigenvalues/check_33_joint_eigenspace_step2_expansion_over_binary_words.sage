# 対象ラベル: check_joint_eigenspace_decomposition
# Step 2 の鎖を、(2) の和を def_sum_over_binary_words（m, n → 2^M, r → M）どおりに組んで一行ずつ厳密に確かめる（M = 2, 3, 4）。
#   Σ_{ε∈{0,1}^M} Q̌_ε = Σ_{ε∈{0,1}^M} ∏_μ R_μ^{(ε_μ)}          （Q̌_ε の定義）
#                      = ∏_μ (R_μ^{(1)} + R_μ^{(0)})              （expansion_of_finite_product_of_two_term_sums を右辺から左辺へ）
#                      = ∏_μ I                                     （Step 0 の和）
#                      = I                                         （finite_product_of_identity_matrices）
# check_32 は 1 行目の和を Sage の sum で組んでいた。ここでは定義どおり、最後の成分で 1 を 0 より先に足す帰納法で組む。
# ň_μ は check_24・check_30〜check_32 と同じく Jordan–Wigner のフェルミ演算子 c_μ から作る n_μ := c_μ^T c_μ。
# 否定コントロール: R_μ^{(0)} を I − ň_μ でなく別の行列にすると、展開の行は成り立つが Step 0 の和の行が外れる。
# 帰属: 成分は QQ（厳密計算）。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")


def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def finite_product(mats):
    acc = mats[0]                                      # def_finite_product_of_matrices の 1 項
    for A in mats[1:]:
        acc = body_product(acc, A)                     # def_finite_product_of_matrices の帰納
    return acc


def binary_word_sum(r, B):
    """def_sum_over_binary_words: B は {0,1}^r の元（タプル）から行列への写像。"""
    if r == 1:
        return body_sum(B((1,)), B((0,)))
    return binary_word_sum(r - 1, lambda ep: body_sum(B(ep + (1,)), B(ep + (0,))))


count = 0
neg = 0
sz = matrix(QQ, [[1, 0], [0, -1]])
lower = matrix(QQ, [[0, 1], [0, 0]])
id2 = identity_matrix(QQ, 2)
for M in range(2, 5):
    N = 2 ^ M
    c = [kron([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    ns = [c[mu].transpose() * c[mu] for mu in range(M)]
    Id = body_identity(QQ, N)
    R1 = ns
    R0 = [body_difference(Id, n) for n in ns]
    R = lambda eps: [R1[mu] if eps[mu] == 1 else R0[mu] for mu in range(M)]
    Q = lambda eps: finite_product(R(eps))                         # Q̌_ε の定義（冒頭）
    lines = [
        binary_word_sum(M, Q),
        binary_word_sum(M, lambda eps: finite_product(R(eps))),    # Q̌_ε の定義
        finite_product([body_sum(R1[mu], R0[mu]) for mu in range(M)]),   # expansion_of_finite_product_of_two_term_sums
        finite_product([Id] * M),                                  # Step 0 の和を各因子へ
        Id,                                                        # finite_product_of_identity_matrices
    ]
    for A, B in zip(lines, lines[1:]):
        assert A == B, ("step2", M)
        count += 1
    # 否定コントロール: R^{(0)} を零行列に替えると Step 0 の和の行だけが外れる
    Z = [matrix(QQ, N, N, 0)] * M
    alt = [binary_word_sum(M, lambda eps: finite_product([R1[mu] if eps[mu] == 1 else Z[mu] for mu in range(M)])),
           finite_product([body_sum(R1[mu], Z[mu]) for mu in range(M)]),
           finite_product([Id] * M)]
    assert alt[0] == alt[1]
    assert alt[1] != alt[2]
    neg += 1

print("PASS check_joint_eigenspace_decomposition Step 2 の鎖（和は def_sum_over_binary_words）: %d 段、否定コントロール %d 行" % (count, neg))
print("RESULT: PASS")
