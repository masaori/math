# 対象ラベル: claim_no_rational_square_two
# 負の枝：左の負号の積
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for q in _nrs_negative:
    lhs = (-q)*(-q)
    rhs = -(q*(-q))
    assert lhs == rhs
    checked += 1
_nrs_report("check_negative_left_product", checked)
