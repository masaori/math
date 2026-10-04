# 対象ラベル: claim_no_rational_square_two
# 指数：v2(1)=0
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))
checked = 0
for _ in range(1):
    lhs = ZZ(2).valuation(2)-ZZ(0)
    rhs = ZZ(2).valuation(2)-ZZ(1).valuation(2)
    assert lhs == rhs
    checked += 1
_nrs_report("check_prime_one_exponent", checked)
