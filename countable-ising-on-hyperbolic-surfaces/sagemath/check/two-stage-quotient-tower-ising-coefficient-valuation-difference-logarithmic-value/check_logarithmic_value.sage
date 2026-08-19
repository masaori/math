# 対象ラベル: def_quotient_tower_two_stage_ising_coefficient_valuation_difference_logarithmic_value

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(
    os.path.join(
        _dir,
        "../two-stage-quotient-tower-ising-coefficient-valuation-difference-finite-support/check_finite_support.sage",
    )
)


def valuation_difference_logarithmic_value(degree):
    support = valuation_difference_support(degree)
    return tuple(
        (ZZ(prime), coefficient_valuation_difference(degree, prime))
        for prime in support
    )


expected_logarithmic_values = {
    0: (),
    2: ((ZZ(2), ZZ(1)), (ZZ(3), ZZ(1))),
}

for degree in joint_positive_degrees:
    support = valuation_difference_support(degree)
    logarithmic_value = valuation_difference_logarithmic_value(degree)

    assert logarithmic_value == expected_logarithmic_values[degree]
    assert len(logarithmic_value) == len(support)
    assert tuple(prime for prime, coefficient in logarithmic_value) == support

    for prime, coefficient in logarithmic_value:
        assert prime.is_prime()
        assert coefficient in ZZ
        assert coefficient != 0
        assert coefficient == coefficient_valuation_difference(degree, prime)

print(
    "RESULT: PASS — at every joint-positive degree, the nonzero two-stage "
    "coefficient valuation differences form a finite-support integer coordinate "
    "tuple, hence define an element of the logarithmic ordered group; degree 0 "
    "gives the zero element and degree 2 gives ell_2 + ell_3"
)
