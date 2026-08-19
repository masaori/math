# 対象ラベル: def_quotient_tower_positive_rational_logarithmic_value_map


def prime_valuation_by_repeated_division(positive_integer, prime):
    assert positive_integer in ZZ and positive_integer > 0
    assert prime in ZZ and prime.is_prime()

    quotient = ZZ(positive_integer)
    exponent = ZZ(0)
    while quotient % prime == 0:
        quotient //= prime
        exponent += 1
    return exponent


def positive_rational_logarithmic_value(rational):
    rational = QQ(rational)
    assert rational > 0

    numerator = ZZ(rational.numerator())
    denominator = ZZ(rational.denominator())
    assert gcd(numerator, denominator) == 1

    candidate_primes = tuple(
        prime
        for prime in prime_range(2, numerator * denominator + 1)
        if numerator % prime == 0 or denominator % prime == 0
    )
    return tuple(
        (
            ZZ(prime),
            prime_valuation_by_repeated_division(numerator, prime)
            - prime_valuation_by_repeated_division(denominator, prime),
        )
        for prime in candidate_primes
    )


examples = {
    QQ(1): (),
    QQ(12): ((ZZ(2), ZZ(2)), (ZZ(3), ZZ(1))),
    QQ(1) / QQ(18): ((ZZ(2), ZZ(-1)), (ZZ(3), ZZ(-2))),
    QQ(45) / QQ(28): (
        (ZZ(2), ZZ(-2)),
        (ZZ(3), ZZ(2)),
        (ZZ(5), ZZ(1)),
        (ZZ(7), ZZ(-1)),
    ),
}

for rational, expected_coordinates in examples.items():
    coordinates = positive_rational_logarithmic_value(rational)
    numerator = ZZ(rational.numerator())
    denominator = ZZ(rational.denominator())

    assert coordinates == expected_coordinates
    assert len({prime for prime, exponent in coordinates}) == len(coordinates)
    assert all(prime.is_prime() for prime, exponent in coordinates)
    assert all(exponent in ZZ and exponent != 0 for prime, exponent in coordinates)
    assert prod(prime ** exponent for prime, exponent in coordinates) == rational
    assert all((numerator * denominator) % prime == 0 for prime, exponent in coordinates)

print(
    "RESULT: PASS — the reduced numerator and denominator of every positive "
    "rational example give a finite-support integer prime-exponent tuple; "
    "the tuple reconstructs the original rational exactly, including the "
    "empty tuple for 1 and negative coordinates from denominators"
)
