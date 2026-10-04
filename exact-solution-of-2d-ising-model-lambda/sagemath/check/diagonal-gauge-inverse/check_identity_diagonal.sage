# 対象ラベル: claim_diagonal_gauge_inverse
# 単位行列の対角成分
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for case in diagonal_gauge_matrix_rows("diagonal"):
    M, N, i, j, size, product_matrix, identity, m, n = case["M"], case["N"], case["i"], case["j"], case["size"], case["product_matrix"], case["identity"], case["m"], case["n"]
    lhs = _dg_field(1)
    rhs = identity[i,i]
    assert lhs == rhs
    checked += 1
print("check_identity_diagonal: PASS (%s 等式)" % checked)
