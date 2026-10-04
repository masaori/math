# 対象ラベル: claim_no_rational_square_two
# 指数：2=2/1 での w2
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for _ in range(1):
    lhs = ZZ(2).valuation(2)-ZZ(1).valuation(2)
    rhs = _nrs_w2(QQ(2))
    assert lhs == rhs
    checked += 1
_nrs_report("check_two_rational_exponent", checked)
