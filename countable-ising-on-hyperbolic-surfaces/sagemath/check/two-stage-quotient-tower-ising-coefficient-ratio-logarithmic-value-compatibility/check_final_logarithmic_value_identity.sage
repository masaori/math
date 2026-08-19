# 対象ラベル: theorem_quotient_tower_two_stage_ising_coefficient_ratio_logarithmic_value_compatibility
# 式ペア: log_Lambda(Omega_fine(m)/Omega_coarse(m)) = Delta L_T(m)
# 帰属: both sides lie in Lambda and are represented by finite-support ZZ coordinates

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for degree in joint_positive_degrees:
    left_hand_side = positive_rational_logarithmic_value(coefficient_ratio(degree))
    right_hand_side = valuation_difference_logarithmic_value(degree)
    assert left_hand_side == right_hand_side

print(
    "RESULT: PASS — for every joint-positive degree, the Lambda value of the "
    "fine-to-coarse Ising coefficient ratio equals the Lambda value obtained "
    "by aggregating the two-stage coefficient valuation differences"
)
