# 対象ラベル: claim_polynomial_diagonal_gauge_inverse
# 本文の等号: 多項式行列の積を有限和へ開く
# 式ペア（辺の矢印を省いた添字）: $(\widehat M\widehat N)_{e,f} = \sum_g\widehat M_{e,g}\widehat N_{g,f}$
# 帰属: C: Qbar → Qbar[x]。e,f,g,h は向き付き辺、F はその有限部分集合、h∉F。r_g と M,N の成分は Qbar、両辺は Qbar[x]。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for row in _pdgi_rows["product"]:
    lhs = row[0]
    rhs = row[1]
    assert lhs == rhs, ("matrix_product_definition", lhs, rhs)
    checked += 1
print("RESULT: PASS (多項式行列の積を有限和へ開く: %s 等式)" % checked)
