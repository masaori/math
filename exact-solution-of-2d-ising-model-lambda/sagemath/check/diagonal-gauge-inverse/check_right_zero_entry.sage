# 対象ラベル: claim_diagonal_gauge_inverse
# 右行列の対角以外の成分
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for case in diagonal_gauge_matrix_rows("off_diagonal"):
    M, N, i, j, size, product_matrix, identity, m, n = case["M"], case["N"], case["i"], case["j"], case["size"], case["product_matrix"], case["identity"], case["m"], case["n"]
    lhs = m*N[i,j]
    rhs = m*_dg_field(0)
    assert lhs == rhs
    checked += 1
print("check_right_zero_entry: PASS (%s 等式)" % checked)
