# 対象ラベル: claim_no_rational_square_two
# 整数 m>=1：二の定義
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for _ in range(1):
    lhs = ZZ(1)+ZZ(1)
    rhs = ZZ(2)
    assert lhs == rhs
    checked += 1
_nrs_report("check_high_two_definition", checked)
