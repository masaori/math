# 対象ラベル: claim_diagonal_gauge_inverse
# 対角以外の成分
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for case in diagonal_gauge_matrix_rows("zero"):
    M, N, i, j, g = case["M"], case["N"], case["i"], case["j"], case["g"]
    lhs = M[i,g]*N[g,j]
    rhs = _dg_field(0)*N[g,j]
    assert lhs == rhs
    checked += 1
print("check_zero_entry: PASS (%s 等式)" % checked)
