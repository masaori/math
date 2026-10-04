# 対象ラベル: claim_diagonal_gauge_inverse
# 零項を有限和から除く
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for case in diagonal_gauge_matrix_rows("all"):
    M, N, i, j, size, product_matrix, identity, m, n = case["M"], case["N"], case["i"], case["j"], case["size"], case["product_matrix"], case["identity"], case["m"], case["n"]
    lhs = sum((M[i,g]*N[g,j] for g in range(size)), _dg_field(0))
    rhs = M[i,i]*N[i,j]
    assert lhs == rhs
    checked += 1
print("check_remove_zero_terms: PASS (%s 等式)" % checked)
