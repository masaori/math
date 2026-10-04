# 対象ラベル: claim_polynomial_diagonal_gauge_inverse
# 本文の等号: 定数多項式の成分を代入する
# 式ペア（辺の矢印を省いた添字）: $\sum_g\widehat M_{e,g}\widehat N_{g,f} = \sum_g C(M_{e,g})C(N_{g,f})$
# 帰属: C: Qbar → Qbar[x]。e,f,g,h は向き付き辺、F はその有限部分集合、h∉F。r_g と M,N の成分は Qbar、両辺は Qbar[x]。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for row in _pdgi_rows["product"]:
    lhs = row[1]
    rhs = row[2]
    assert lhs == rhs, ("matrix_entries", lhs, rhs)
    checked += 1
print("RESULT: PASS (定数多項式の成分を代入する: %s 等式)" % checked)
