# 対象ラベル: claim_polynomial_diagonal_gauge_inverse
# 本文の等号: 多項式の有限和へ戻す
# 式ペア（辺の矢印を省いた添字）: $C(r_h)+\sum_{g\in F}C(r_g) = \sum_{g\in F\cup\{h\}}C(r_g)$
# 帰属: C: Qbar → Qbar[x]。e,f,g,h は向き付き辺、F はその有限部分集合、h∉F。r_g と M,N の成分は Qbar、両辺は Qbar[x]。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for row in _pdgi_rows["insert"]:
    lhs = row[3]
    rhs = row[4]
    assert lhs == rhs, ("insert_sum_target", lhs, rhs)
    checked += 1
print("RESULT: PASS (多項式の有限和へ戻す: %s 等式)" % checked)
