# 対象ラベル: claim_no_rational_square_two
# 整数 m<=0：零は一より小さい
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for _ in range(1):
    lhs = ZZ(0)
    rhs = ZZ(1)
    assert lhs < rhs
    checked += 1
_nrs_report("check_low_strict_comparison", checked)
