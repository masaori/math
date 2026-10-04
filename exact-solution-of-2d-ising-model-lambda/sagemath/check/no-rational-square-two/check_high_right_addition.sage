# 対象ラベル: claim_no_rational_square_two
# 整数 m>=1：右の加数を比較
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for m in _nrs_high:
    lhs = ZZ(1)+m
    rhs = ZZ(1)+ZZ(1)
    assert lhs >= rhs
    checked += 1
_nrs_report("check_high_right_addition", checked)
