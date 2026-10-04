# 対象ラベル: claim_diagonal_gauge_inverse
# 逆方向の v の定義
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for case in diagonal_gauge_scalar_rows():
    z, p, q, u, v = case["z"], case["p"], case["q"], case["u"], case["v"]
    lhs = v*u
    rhs = (z^(-q)*z^(-p))*u
    assert lhs == rhs
    checked += 1
print("check_backward_inverse_weight: PASS (%s 等式)" % checked)
