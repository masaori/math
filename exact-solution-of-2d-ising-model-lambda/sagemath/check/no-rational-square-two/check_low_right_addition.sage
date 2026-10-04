# 対象ラベル: claim_no_rational_square_two
# 整数 m<=0：右の加数を比較
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for m in _nrs_low:
    lhs = ZZ(0)+m
    rhs = ZZ(0)+ZZ(0)
    assert lhs <= rhs
    checked += 1
_nrs_report("check_low_right_addition", checked)
