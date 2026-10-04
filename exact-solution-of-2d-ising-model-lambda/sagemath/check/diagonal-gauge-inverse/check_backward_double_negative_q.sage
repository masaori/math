# 対象ラベル: claim_diagonal_gauge_inverse
# q の二重負号
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for case in diagonal_gauge_scalar_rows():
    z, p, q, u, v = case["z"], case["p"], case["q"], case["u"], case["v"]
    lhs = (z^(-q)*z^(-p))*(z^(-(-p))*z^q)
    rhs = (z^(-q)*z^(-p))*(z^(-(-p))*z^(-(-q)))
    assert lhs == rhs
    checked += 1
print("check_backward_double_negative_q: PASS (%s 等式)" % checked)
