# SageMath: 固定剰余類格子の非零係数に対する指定素数付値
# 対象ラベル: def_fixed_quotient_coefficient_valuation
# 帰属: NN、ZZ だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-ising-partition-polynomial/_prelude.sage",
    )
)

support = (0, 7, 12, 14, 15) + tuple(range(17, 57))
specified_primes = (2, 3, 5, 7)
coefficient_by_broken_edge_count = tuple(ZZ(value) for value in expected_coefficients)

expected_profiles = {
    2: (1, 4, 3, 7, 4, 5, 3, 5, 2, 4, 4, 7, 1, 5, 4, 5, 4, 5, 4, 6, 1, 5, 5, 5, 3, 7, 4, 4, 2, 5, 4, 5, 3, 5, 4, 4, 2, 6, 3, 7, 2, 4, 7, 6, 1),
    3: (0, 1, 1, 1, 0, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2, 0, 2, 1, 1, 1, 5, 0, 1, 2, 0, 1, 1, 1, 2, 4, 2, 1, 1, 2, 4, 1, 0, 2, 5, 2, 1, 2),
    5: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0),
    7: (0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 2, 0, 1, 1, 1, 1, 1, 1, 0, 1, 2, 3, 1, 2, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1),
}


def valuation_by_repeated_division(coefficient, prime):
    coefficient = ZZ(coefficient)
    prime = ZZ(prime)
    assert coefficient > 0
    assert prime.is_prime()

    remaining = coefficient
    exponent = ZZ.zero()
    while remaining % prime == 0:
        remaining //= prime
        exponent += 1

    assert coefficient == prime**exponent * remaining
    assert remaining % prime != 0
    return exponent


actual_profiles = {}
for prime in specified_primes:
    profile = tuple(
        valuation_by_repeated_division(
            coefficient_by_broken_edge_count[broken_edge_count],
            prime,
        )
        for broken_edge_count in support
    )
    actual_profiles[prime] = profile
    assert profile == expected_profiles[prime]

    for broken_edge_count, exponent in zip(support, profile):
        coefficient = ZZ(coefficient_by_broken_edge_count[broken_edge_count])
        admissible_exponents = tuple(
            candidate
            for candidate in range(coefficient.nbits() + 1)
            if coefficient % prime**candidate == 0
        )
        assert admissible_exponents
        assert max(admissible_exponents) == exponent

assert min(actual_profiles[2]) >= 1
assert max(actual_profiles[2]) == 7

print(
    "RESULT: PASS — repeated exact division, without complete factorization, "
    "reproduces the stored coefficient valuation profiles for p=2,3,5,7; "
    "the 2-adic valuations range from 1 through 7"
)
