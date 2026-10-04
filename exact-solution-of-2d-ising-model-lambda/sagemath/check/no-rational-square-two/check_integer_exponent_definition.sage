# 対象ラベル: claim_no_rational_square_two
# 指数：m=w2(r) の定義
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for r in _nrs_positive:
    m = _nrs_w2(r)
    lhs = _nrs_w2(r)+_nrs_w2(r)
    rhs = m+m
    assert lhs == rhs
    checked += 1
_nrs_report("check_integer_exponent_definition", checked)
