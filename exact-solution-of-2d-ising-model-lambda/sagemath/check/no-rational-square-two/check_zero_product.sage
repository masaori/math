# 対象ラベル: claim_no_rational_square_two
# 零の枝：零元との積
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for _ in range(1):
    lhs = QQ(0)*QQ(0)
    rhs = QQ(0)
    assert lhs == rhs
    checked += 1
_nrs_report("check_zero_product", checked)
