# 対象ラベル: claim_diagonal_gauge_inverse
# 準備の等式を逆方向へ適用
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for case in diagonal_gauge_scalar_rows():
    z, p, q, u, v = case["z"], case["p"], case["q"], case["u"], case["v"]
    lhs = (z^(-q)*z^(-p))*(z^(-(-p))*z^(-(-q)))
    rhs = _dg_field(1)
    assert lhs == rhs
    checked += 1
print("check_backward_cancellation: PASS (%s 等式)" % checked)
