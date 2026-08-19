# 対象ラベル: theorem_quotient_tower_two_stage_ising_coefficient_ratio_logarithmic_value_compatibility

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(
    os.path.join(
        _dir,
        "../two-stage-quotient-tower-ising-coefficient-valuation-difference-logarithmic-value/check_logarithmic_value.sage",
    )
)
load(
    os.path.join(
        _dir,
        "../positive-rational-logarithmic-value-map/check_logarithmic_value_map.sage",
    )
)


def coefficient_ratio(degree):
    fine_coefficient, coarse_coefficient = coefficient_pair(degree)
    assert fine_coefficient > 0 and coarse_coefficient > 0
    return QQ(fine_coefficient) / QQ(coarse_coefficient)
