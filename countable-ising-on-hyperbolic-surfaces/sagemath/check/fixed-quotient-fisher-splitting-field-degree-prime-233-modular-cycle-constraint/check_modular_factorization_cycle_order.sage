# SageMath: 次数四十四の既約因子の 233 進分解型と置換位数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_233_modular_cycle_constraint
# 式ペア: factor degrees (1, 2, 3, 3, 4, 14, 17) and lcm = 1428
# 帰属: ZZ[x]、GF(233)[x]、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

prime = ZZ(233)
finite_field = GF(prime)
finite_polynomial_ring = PolynomialRing(finite_field, "y")
y = finite_polynomial_ring.gen()
reduced_factor = finite_polynomial_ring(irreducible_factor)

assert irreducible_factor.leading_coefficient() % prime == 63
assert irreducible_factor.discriminant() % prime == 212
assert reduced_factor.is_squarefree()

expected_factors = [
    y + 136,
    y^2 + 174*y + 155,
    y^3 + 97*y^2 + 26*y + 177,
    y^3 + 102*y^2 + 228*y + 77,
    y^4 + 136*y^3 + 109*y^2 + 139*y + 100,
    y^14 + 214*y^13 + 51*y^12 + 179*y^11 + 129*y^10 + 98*y^9
    + 32*y^8 + 5*y^7 + 137*y^6 + 110*y^5 + 129*y^4 + 73*y^3
    + 31*y^2 + 8*y + 95,
    y^17 + 227*y^16 + 104*y^15 + 46*y^14 + 130*y^13 + 11*y^12
    + 53*y^11 + 56*y^10 + 178*y^9 + 164*y^8 + 199*y^7 + 129*y^6
    + 33*y^5 + 23*y^4 + 193*y^3 + 226*y^2 + 228*y + 36,
]

assert all(factor.is_monic() for factor in expected_factors)
assert all(factor.is_irreducible() for factor in expected_factors)
assert [factor.degree() for factor in expected_factors] == [1, 2, 3, 3, 4, 14, 17]
assert reduced_factor == finite_field(63) * prod(expected_factors)

cycle_order = lcm([factor.degree() for factor in expected_factors])
assert cycle_order == 1428
assert cycle_order in NN

print(
    "RESULT: PASS — modulo 233 the degree-44 factor is squarefree with "
    "irreducible degrees 1,2,3,3,4,14,17, whose cycle order is 1428"
)
