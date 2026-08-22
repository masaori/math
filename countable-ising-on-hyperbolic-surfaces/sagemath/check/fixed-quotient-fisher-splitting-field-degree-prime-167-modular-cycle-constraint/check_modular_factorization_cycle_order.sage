# SageMath: 次数四十四の既約因子の 167 進分解型と置換位数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_167_modular_cycle_constraint
# 式ペア: factor degrees (1, 2, 4, 4, 6, 8, 19) and lcm = 456
# 帰属: ZZ[x]、GF(167)[x]、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

prime = ZZ(167)
finite_field = GF(prime)
finite_polynomial_ring = PolynomialRing(finite_field, "y")
y = finite_polynomial_ring.gen()
reduced_factor = finite_polynomial_ring(irreducible_factor)

assert irreducible_factor.leading_coefficient() % prime == 63
assert irreducible_factor.discriminant() % prime == 143
assert reduced_factor.is_squarefree()

expected_factors = [
    y + 4,
    y^2 + 164*y + 27,
    y^4 + 84*y^3 + 24*y^2 + 10*y + 104,
    y^4 + 109*y^3 + 66*y^2 + 119*y + 53,
    y^6 + 154*y^5 + 21*y^4 + 85*y^3 + 105*y^2 + 46*y + 76,
    y^8 + 29*y^7 + 152*y^6 + 41*y^5 + 155*y^4 + 89*y^3
    + 61*y^2 + 123*y + 151,
    y^19 + 67*y^18 + 143*y^17 + 157*y^16 + 149*y^15 + 52*y^14
    + 18*y^13 + 137*y^12 + 126*y^11 + 89*y^10 + 114*y^9 + 143*y^8
    + 149*y^7 + 84*y^6 + 140*y^5 + 32*y^4 + 77*y^3 + 69*y^2
    + 43*y + 59,
]

assert all(factor.is_monic() for factor in expected_factors)
assert all(factor.is_irreducible() for factor in expected_factors)
assert [factor.degree() for factor in expected_factors] == [1, 2, 4, 4, 6, 8, 19]
assert reduced_factor == finite_field(63) * prod(expected_factors)

cycle_order = lcm([factor.degree() for factor in expected_factors])
assert cycle_order == 456
assert cycle_order in NN

print(
    "RESULT: PASS — modulo 167 the degree-44 factor is squarefree with "
    "irreducible degrees 1,2,4,4,6,8,19, whose cycle order is 456"
)
