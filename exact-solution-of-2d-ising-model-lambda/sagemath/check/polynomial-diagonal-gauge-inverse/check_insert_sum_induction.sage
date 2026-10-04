# 対象ラベル: claim_polynomial_diagonal_gauge_inverse
# 本文の等号: 小さい有限集合の和を移す
# 式ペア（辺の矢印を省いた添字）: $C(r_h)+C(\sum_{g\in F}r_g) = C(r_h)+\sum_{g\in F}C(r_g)$
# 帰属: C: Qbar → Qbar[x]。e,f,g,h は向き付き辺、F はその有限部分集合、h∉F。r_g と M,N の成分は Qbar、両辺は Qbar[x]。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for row in _pdgi_rows["insert"]:
    lhs = row[2]
    rhs = row[3]
    assert lhs == rhs, ("insert_sum_induction", lhs, rhs)
    checked += 1
print("RESULT: PASS (小さい有限集合の和を移す: %s 等式)" % checked)
