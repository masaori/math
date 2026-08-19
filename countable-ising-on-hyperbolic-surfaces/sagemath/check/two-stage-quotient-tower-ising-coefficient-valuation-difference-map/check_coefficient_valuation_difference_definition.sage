# 対象ラベル: def_quotient_tower_two_stage_ising_coefficient_valuation_difference_map

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(
    os.path.join(
        _dir,
        "../two-stage-quotient-tower-ising-coefficient-valuation-pair-map/check_coefficient_valuation_pair_definition.sage",
    )
)


def coefficient_valuation_difference(degree, prime):
    fine_valuation, coarse_valuation = coefficient_valuation_pair(degree, prime)
    return ZZ(fine_valuation) - ZZ(coarse_valuation)


expected_differences = {
    (0, 2): ZZ(0),
    (0, 3): ZZ(0),
    (0, 5): ZZ(0),
    (0, 7): ZZ(0),
    (2, 2): ZZ(1),
    (2, 3): ZZ(1),
    (2, 5): ZZ(0),
    (2, 7): ZZ(0),
}

for degree in joint_positive_degrees:
    for prime in specified_primes:
        valuation_pair = coefficient_valuation_pair(degree, prime)
        valuation_difference = coefficient_valuation_difference(degree, prime)
        assert valuation_difference in ZZ
        assert valuation_difference == expected_differences[(degree, prime)]
        assert valuation_difference == ZZ(valuation_pair[0]) - ZZ(valuation_pair[1])

assert ZZ(1) - ZZ(2) == ZZ(-1)

print(
    "RESULT: PASS — on every joint-positive degree and each specified prime, "
    "the two-stage Ising coefficient valuation difference is exactly the fine "
    "valuation minus the coarse valuation in ZZ; the codomain permits negative "
    "integers without asserting that the graph example realizes one"
)
