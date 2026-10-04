# 対象ラベル: claim_no_rational_square_two
# 指数：対数の加法性
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for r in _nrs_positive:
    lhs = _nrs_log(r*r).get(ZZ(2),ZZ(0))
    rhs = _nrs_add_logs(_nrs_log(r),_nrs_log(r)).get(ZZ(2),ZZ(0))
    assert lhs == rhs
    checked += 1
_nrs_report("check_log_additivity", checked)
