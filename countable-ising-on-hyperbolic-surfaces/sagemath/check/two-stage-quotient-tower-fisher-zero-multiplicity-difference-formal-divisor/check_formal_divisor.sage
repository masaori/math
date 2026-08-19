# SageMath: 二段 Fisher 零点重複度差の形式的因子
# 対象ラベル: def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_formal_divisor
# 帰属: QQbar、ZZ、有限台写像だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(check_directory, "_prelude.sage"))

ordinary_divisor = formal_divisor(
    two_stage_zero_support,
    multiplicity_difference,
)
assert set(ordinary_divisor) == multiplicity_difference_support(
    two_stage_zero_support,
    multiplicity_difference,
)
assert len(ordinary_divisor) == 6
assert all(coefficient in {ZZ(-1), ZZ(1)} for coefficient in ordinary_divisor.values())

shared_divisor = formal_divisor(
    shared_two_stage_zero_support,
    lambda alpha: multiplicity_difference(alpha, shared_multiplicity_pair),
)
assert set(shared_divisor) == multiplicity_difference_support(
    shared_two_stage_zero_support,
    lambda alpha: multiplicity_difference(alpha, shared_multiplicity_pair),
)
assert QQbar(-1) not in shared_divisor
assert len(shared_divisor) == 6
assert all(coefficient != 0 for coefficient in shared_divisor.values())

print(
    "RESULT: PASS — both exact QQbar formal divisors have finite integer "
    "coefficient support, and the shared root -1 is absent because its "
    "fine and coarse multiplicities cancel"
)
