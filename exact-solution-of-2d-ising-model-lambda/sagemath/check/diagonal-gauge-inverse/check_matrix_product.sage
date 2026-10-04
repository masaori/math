# 対象ラベル: claim_diagonal_gauge_inverse
# 行列積の有限和
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for case in diagonal_gauge_matrix_rows("all"):
    M, N, i, j, size, product_matrix, identity, m, n = case["M"], case["N"], case["i"], case["j"], case["size"], case["product_matrix"], case["identity"], case["m"], case["n"]
    lhs = product_matrix[i,j]
    rhs = sum((M[i,g]*N[g,j] for g in range(size)), _dg_field(0))
    assert lhs == rhs
    checked += 1
print("check_matrix_product: PASS (%s 等式)" % checked)
