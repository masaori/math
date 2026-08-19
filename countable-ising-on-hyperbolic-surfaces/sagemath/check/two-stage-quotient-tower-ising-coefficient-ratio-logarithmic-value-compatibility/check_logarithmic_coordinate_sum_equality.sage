# 対象ラベル: theorem_quotient_tower_two_stage_ising_coefficient_ratio_logarithmic_value_compatibility
# 式ペア: sum_p v_p(a/b) ell_p = sum_p Delta nu_T(m,p) ell_p
# 帰属: both sides are finite-support integer coordinate tuples in Lambda

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

expected_coordinates = {
    0: (),
    2: ((ZZ(2), ZZ(1)), (ZZ(3), ZZ(1))),
}

for degree in joint_positive_degrees:
    ratio_coordinates = positive_rational_logarithmic_value(coefficient_ratio(degree))
    difference_coordinates = valuation_difference_logarithmic_value(degree)
    assert ratio_coordinates == difference_coordinates
    assert ratio_coordinates == expected_coordinates[degree]

print(
    "RESULT: PASS — the finite-support logarithmic coordinates of the fine-to-"
    "coarse coefficient ratio equal the aggregated valuation-difference "
    "coordinates; degree 0 is zero and degree 2 is ell_2 + ell_3"
)
