# 対象ラベル: claim_diagonal_gauge_inverse
# 外側の積の結合則
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for case in diagonal_gauge_scalar_rows(preparation=True):
    z, p, q, u, v = case["z"], case["p"], case["q"], case["u"], case["v"]
    lhs = (z^p*z^q)*(z^(-q)*z^(-p))
    rhs = z^p*(z^q*(z^(-q)*z^(-p)))
    assert lhs == rhs
    checked += 1
print("check_associate_outer: PASS (%s 等式)" % checked)
