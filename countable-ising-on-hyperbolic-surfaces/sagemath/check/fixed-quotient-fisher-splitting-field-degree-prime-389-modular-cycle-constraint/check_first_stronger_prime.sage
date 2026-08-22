# SageMath: 367 より大きい最初の分解体次数候補を真に縮める非分岐素数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_389_modular_cycle_constraint
# 帰属: ZZ[x]、GF(p)[x]、ZZ、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

prior_degree_divisor = ZZ(9957281351799600)
prior_quotient_factor = ZZ(2489320337949900)
irreducible_degree = ZZ(44)
tested_primes = [ZZ(373), ZZ(379), ZZ(383), ZZ(389)]
search_results = []

for prime in tested_primes:
    assert irreducible_factor.leading_coefficient() % prime != 0
    assert irreducible_factor.discriminant() % prime != 0
    finite_polynomial_ring = PolynomialRing(GF(prime), "y")
    factorization = finite_polynomial_ring(irreducible_factor).factor()
    factor_degrees = sorted(
        factor.degree()
        for factor, exponent in factorization
        for occurrence in range(exponent)
    )
    cycle_order = lcm(factor_degrees)
    combined_degree_divisor = lcm(prior_degree_divisor, cycle_order)
    quotient_factor = combined_degree_divisor // gcd(
        combined_degree_divisor,
        irreducible_degree,
    )
    search_results.append((prime, factor_degrees, cycle_order, quotient_factor))

assert all(result[3] == prior_quotient_factor for result in search_results[:-1])
assert search_results[-1] == (
    ZZ(389),
    [1, 43],
    ZZ(43),
    ZZ(107040774531845700),
)

print(
    "RESULT: PASS — among primes 373,379,383,389, the first stronger "
    "unramified cycle constraint occurs at 389 with factor degrees 1,43"
)
