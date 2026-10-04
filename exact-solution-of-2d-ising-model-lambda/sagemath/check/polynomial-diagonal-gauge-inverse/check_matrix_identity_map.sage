# 対象ラベル: claim_polynomial_diagonal_gauge_inverse
# 本文の等号: 単位行列の成分を移す
# 式ペア（辺の矢印を省いた添字）: $C((I_{\overline{\mathbb Q}})_{e,f}) = (I_x)_{e,f}$
# 帰属: C: Qbar → Qbar[x]。e,f,g,h は向き付き辺、F はその有限部分集合、h∉F。r_g と M,N の成分は Qbar、両辺は Qbar[x]。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for row in _pdgi_rows["product"]:
    lhs = row[6]
    rhs = row[7]
    assert lhs == rhs, ("matrix_identity_map", lhs, rhs)
    checked += 1
print("RESULT: PASS (単位行列の成分を移す: %s 等式)" % checked)
