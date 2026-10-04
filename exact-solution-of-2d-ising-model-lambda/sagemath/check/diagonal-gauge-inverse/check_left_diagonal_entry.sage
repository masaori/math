# 対象ラベル: claim_diagonal_gauge_inverse
# 左対角成分の記号
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for case in diagonal_gauge_matrix_rows("all"):
    M, N, i, j, size, product_matrix, identity, m, n = case["M"], case["N"], case["i"], case["j"], case["size"], case["product_matrix"], case["identity"], case["m"], case["n"]
    lhs = M[i,i]*N[i,j]
    rhs = m*N[i,j]
    assert lhs == rhs
    checked += 1
print("check_left_diagonal_entry: PASS (%s 等式)" % checked)
