# 対象ラベル: theorem_quotient_tower_two_stage_ising_coefficient_valuation_difference_finite_support

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(
    os.path.join(
        _dir,
        "../two-stage-quotient-tower-ising-coefficient-valuation-difference-map/check_coefficient_valuation_difference_definition.sage",
    )
)


def prime_divisors_by_finite_search(positive_integer):
    positive_integer = ZZ(positive_integer)
    assert positive_integer > 0
    return tuple(
        prime
        for prime in range(2, positive_integer + 1)
        if ZZ(prime).is_prime() and positive_integer % prime == 0
    )


def valuation_difference_support(degree):
    fine_coefficient, coarse_coefficient = coefficient_pair(degree)
    coefficient_product = ZZ(fine_coefficient) * ZZ(coarse_coefficient)
    assert coefficient_product > 0
    candidate_primes = prime_divisors_by_finite_search(coefficient_product)
    return tuple(
        prime
        for prime in candidate_primes
        if coefficient_valuation_difference(degree, prime) != 0
    )


expected_supports = {
    0: (),
    2: (2, 3),
}

for degree in joint_positive_degrees:
    fine_coefficient, coarse_coefficient = coefficient_pair(degree)
    coefficient_product = ZZ(fine_coefficient) * ZZ(coarse_coefficient)
    prime_divisors = prime_divisors_by_finite_search(coefficient_product)
    support = valuation_difference_support(degree)

    assert support == expected_supports[degree]
    assert set(support).issubset(set(prime_divisors))

    for prime in range(2, coefficient_product + 2):
        prime = ZZ(prime)
        if prime.is_prime() and coefficient_valuation_difference(degree, prime) != 0:
            assert coefficient_product % prime == 0

print(
    "RESULT: PASS — for each joint-positive degree, every prime with nonzero "
    "two-stage coefficient valuation difference divides the product of the "
    "two positive coefficients; the support is contained in a finite divisor set"
)
