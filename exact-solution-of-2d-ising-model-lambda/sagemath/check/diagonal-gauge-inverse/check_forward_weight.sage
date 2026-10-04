# 対象ラベル: claim_diagonal_gauge_inverse
# 順方向の u の定義
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for case in diagonal_gauge_scalar_rows():
    z, p, q, u, v = case["z"], case["p"], case["q"], case["u"], case["v"]
    lhs = u*v
    rhs = (z^p*z^q)*v
    assert lhs == rhs
    checked += 1
print("check_forward_weight: PASS (%s 等式)" % checked)
