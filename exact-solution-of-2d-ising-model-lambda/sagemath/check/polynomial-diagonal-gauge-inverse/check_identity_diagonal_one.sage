# 対象ラベル: claim_polynomial_diagonal_gauge_inverse
# 本文の等号: 定数埋込みは一を保つ
# 式ペア（辺の矢印を省いた添字）: $C(1) = 1$
# 帰属: C: Qbar → Qbar[x]。e,f,g,h は向き付き辺、F はその有限部分集合、h∉F。r_g と M,N の成分は Qbar、両辺は Qbar[x]。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for row in _pdgi_rows["diagonal"]:
    lhs = row[1]
    rhs = row[2]
    assert lhs == rhs, ("identity_diagonal_one", lhs, rhs)
    checked += 1
print("RESULT: PASS (定数埋込みは一を保つ: %s 等式)" % checked)
