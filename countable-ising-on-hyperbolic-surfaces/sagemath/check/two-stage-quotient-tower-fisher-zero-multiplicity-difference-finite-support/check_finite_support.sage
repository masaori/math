# SageMath: 二段 Fisher 零点重複度差の有限台
# 対象ラベル: theorem_quotient_tower_two_stage_fisher_zero_multiplicity_difference_finite_support
# 帰属: ZZ[x]、QQbar[x]、ZZ、有限集合だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(check_directory, "_prelude.sage"))

ordinary_support = multiplicity_difference_support(
    two_stage_zero_support,
    multiplicity_difference,
)
assert ordinary_support <= two_stage_zero_support
assert len(two_stage_zero_support) == 6
assert len(ordinary_support) == 6

shared_support = multiplicity_difference_support(
    shared_two_stage_zero_support,
    lambda alpha: multiplicity_difference(alpha, shared_multiplicity_pair),
)
assert shared_support <= shared_two_stage_zero_support
assert QQbar(-1) in shared_two_stage_zero_support
assert QQbar(-1) not in shared_support
assert len(shared_two_stage_zero_support) == 7
assert len(shared_support) == 6
assert shared_support == set(shared_fine_root_multiplicities).symmetric_difference(
    set(shared_coarse_root_multiplicities)
)

print(
    "RESULT: PASS — both nonzero-difference supports are finite subsets of "
    "their exact QQbar two-stage zero supports; the shared root -1 is "
    "excluded because its multiplicity difference is zero"
)
