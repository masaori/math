# SageMath: 固定剰余類格子の正有理評価値に対する指定素数付値
# 対象ラベル: def_fixed_quotient_rational_evaluation_valuation
# 帰属: NN、ZZ、QQ だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-ising-partition-polynomial/_prelude.sage",
    )
)

polynomial_ring = PolynomialRing(QQ, "x")
partition_polynomial = polynomial_ring(expected_coefficients)
specified_primes = (2, 3, 5, 7)
positive_rational_inputs = (QQ(1) / 2, QQ(2) / 3, QQ(3) / 2)
expected_valuations = {
    QQ(1) / 2: {2: -55, 3: 14, 5: 0, 7: 0},
    QQ(2) / 3: {2: 1, 3: -54, 5: 12, 7: 0},
    QQ(3) / 2: {2: -55, 3: 0, 5: 12, 7: 1},
}


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

    assert positive_integer == prime**exponent * remaining
    assert remaining % prime != 0
    return exponent


assert partition_polynomial.degree() == 56

for rational_input in positive_rational_inputs:
    numerator = ZZ(rational_input.numerator())
    denominator = ZZ(rational_input.denominator())
    assert numerator > 0
    assert denominator > 0
    assert gcd(numerator, denominator) == 1

    rational_value = QQ(partition_polynomial(rational_input))
    cleared_evaluation = ZZ(
        denominator**56 * rational_value
    )
    direct_cleared_evaluation = sum(
        ZZ(expected_coefficients[broken_edge_count])
        * numerator**broken_edge_count
        * denominator**(56 - broken_edge_count)
        for broken_edge_count in range(57)
    )

    assert rational_value > 0
    assert cleared_evaluation > 0
    assert cleared_evaluation == direct_cleared_evaluation
    assert rational_value == QQ(cleared_evaluation) / denominator**56

    for prime in specified_primes:
        valuation_from_definition = (
            valuation_by_repeated_division(cleared_evaluation, prime)
            - 56 * valuation_by_repeated_division(denominator, prime)
        )
        assert valuation_from_definition == rational_value.valuation(prime)
        assert valuation_from_definition == expected_valuations[rational_input][prime]

print(
    "RESULT: PASS — exact denominator clearing and repeated integer division "
    "reproduce the p-adic valuations of the three positive rational evaluations "
    "for p=2,3,5,7 without complete factorization"
)
