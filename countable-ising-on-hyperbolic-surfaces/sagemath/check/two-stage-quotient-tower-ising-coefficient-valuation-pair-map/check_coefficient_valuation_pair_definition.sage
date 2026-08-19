# 対象ラベル: def_quotient_tower_two_stage_ising_coefficient_valuation_pair_map

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(
    os.path.join(
        _dir,
        "../two-stage-quotient-tower-ising-coefficient-pair-map/_prelude.sage",
    )
)


def valuation_by_repeated_division(positive_integer, prime):
    positive_integer = ZZ(positive_integer)
    prime = ZZ(prime)
    assert positive_integer > 0
    assert prime.is_prime()

    remaining = positive_integer
    exponent = ZZ.zero()
    while remaining % prime == 0:
        remaining //= prime
        exponent += 1
    return exponent


def coefficient_valuation_pair(degree, prime):
    fine_coefficient, coarse_coefficient = coefficient_pair(degree)
    assert fine_coefficient > 0
    assert coarse_coefficient > 0
    return (
        valuation_by_repeated_division(fine_coefficient, prime),
        valuation_by_repeated_division(coarse_coefficient, prime),
    )


specified_primes = (ZZ(2), ZZ(3), ZZ(5), ZZ(7))
joint_positive_degrees = tuple(
    degree
    for degree in range(max(len(fine_edges), len(coarse_edges)) + 2)
    if coefficient_pair(degree)[0] > 0 and coefficient_pair(degree)[1] > 0
)

assert joint_positive_degrees == (0, 2)

expected_pairs = {
    (0, 2): (1, 1),
    (0, 3): (0, 0),
    (0, 5): (0, 0),
    (0, 7): (0, 0),
    (2, 2): (2, 1),
    (2, 3): (1, 0),
    (2, 5): (0, 0),
    (2, 7): (0, 0),
}

for degree in joint_positive_degrees:
    fine_coefficient, coarse_coefficient = coefficient_pair(degree)
    for prime in specified_primes:
        valuation_pair = coefficient_valuation_pair(degree, prime)
        assert valuation_pair == expected_pairs[(degree, prime)]
        assert valuation_pair == (
            ZZ(fine_coefficient).valuation(prime),
            ZZ(coarse_coefficient).valuation(prime),
        )

for degree in (1, 3, 4, 5):
    fine_coefficient, coarse_coefficient = coefficient_pair(degree)
    assert fine_coefficient == 0 or coarse_coefficient == 0

print(
    "RESULT: PASS — on every degree where both two-stage Ising coefficients are "
    "positive, repeated division gives the stated fine/coarse valuation pair for "
    "p=2,3,5,7; degrees with a zero component are excluded"
)
