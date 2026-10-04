# 対象ラベル: claim_no_rational_square_two
# 正の枝：r=q の定義
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for q in _nrs_positive:
    r = q
    lhs = r*r
    rhs = q*q
    assert lhs == rhs
    checked += 1
_nrs_report("check_positive_definition", checked)
