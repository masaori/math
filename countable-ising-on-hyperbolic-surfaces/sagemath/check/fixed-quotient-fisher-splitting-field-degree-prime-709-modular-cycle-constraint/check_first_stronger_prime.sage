# SageMath: 389 より大きい最初の分解体次数候補を真に縮める非分岐素数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_709_modular_cycle_constraint
# 帰属: ZZ[x]、GF(p)[x]、ZZ、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

prior_degree_divisor = ZZ(428163098127382800)
prior_quotient_factor = ZZ(107040774531845700)
irreducible_degree = ZZ(44)
search_results = []

for prime in prime_range(390, 710):
    if irreducible_factor.leading_coefficient() % prime == 0:
        continue
    if irreducible_factor.discriminant() % prime == 0:
        continue
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

stronger_results = [
    result for result in search_results if result[3] > prior_quotient_factor
]

assert stronger_results[0] == (
    ZZ(709),
    [12, 32],
    ZZ(96),
    ZZ(214081549063691400),
)
assert all(result[3] == prior_quotient_factor for result in search_results[:-1])

print(
    "RESULT: PASS — 709 is the first unramified prime after 389 that "
    "strictly strengthens the quotient-degree constraint, with factor degrees 12,32"
)
