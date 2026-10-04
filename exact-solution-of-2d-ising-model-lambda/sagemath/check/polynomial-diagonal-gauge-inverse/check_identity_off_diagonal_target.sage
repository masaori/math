# 対象ラベル: claim_polynomial_diagonal_gauge_inverse
# 本文の等号: 多項式の単位行列の非対角成分
# 式ペア（辺の矢印を省いた添字）: $0 = (I_x)_{e,f}\quad(e\ne f)$
# 帰属: C: Qbar → Qbar[x]。e,f,g,h は向き付き辺、F はその有限部分集合、h∉F。r_g と M,N の成分は Qbar、両辺は Qbar[x]。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for row in _pdgi_rows["off_diagonal"]:
    lhs = row[2]
    rhs = row[3]
    assert lhs == rhs, ("identity_off_diagonal_target", lhs, rhs)
    checked += 1
print("RESULT: PASS (多項式の単位行列の非対角成分: %s 等式)" % checked)
