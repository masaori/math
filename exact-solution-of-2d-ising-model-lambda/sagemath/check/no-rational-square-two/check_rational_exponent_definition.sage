# 対象ラベル: claim_no_rational_square_two
# 指数：二つの対数成分を w2 へ戻す
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for r in _nrs_positive:
    lhs = _nrs_log(r).get(ZZ(2),ZZ(0))+_nrs_log(r).get(ZZ(2),ZZ(0))
    rhs = _nrs_w2(r)+_nrs_w2(r)
    assert lhs == rhs
    checked += 1
_nrs_report("check_rational_exponent_definition", checked)
