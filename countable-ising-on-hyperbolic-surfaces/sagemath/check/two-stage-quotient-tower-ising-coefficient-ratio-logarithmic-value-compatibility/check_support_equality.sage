# 対象ラベル: theorem_quotient_tower_two_stage_ising_coefficient_ratio_logarithmic_value_compatibility
# 式ペア: Supp_v(a/b) = Supp_{Delta nu_T}(m)
# 帰属: both sides are finite sets of primes

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for degree in joint_positive_degrees:
    ratio_support = tuple(
        prime for prime, exponent in positive_rational_logarithmic_value(coefficient_ratio(degree))
    )
    difference_support = valuation_difference_support(degree)
    assert ratio_support == difference_support

print(
    "RESULT: PASS — the positive coefficient ratio and the two-stage valuation "
    "difference have exactly the same finite prime support at every "
    "joint-positive degree"
)
