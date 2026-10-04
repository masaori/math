# 対象ラベル: claim_no_rational_square_two
# 整数 m>=1：左の加数を比較
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for m in _nrs_high:
    lhs = m+m
    rhs = ZZ(1)+m
    assert lhs >= rhs
    checked += 1
_nrs_report("check_high_left_addition", checked)
