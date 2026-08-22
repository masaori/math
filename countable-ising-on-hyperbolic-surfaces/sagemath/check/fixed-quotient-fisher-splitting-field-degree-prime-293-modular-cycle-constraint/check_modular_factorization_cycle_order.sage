# SageMath: 次数四十四の既約因子の 293 進分解型と置換位数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_293_modular_cycle_constraint
# 式ペア: factor degrees (1, 12, 31) and lcm = 372
# 帰属: ZZ[x]、GF(293)[x]、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

prime = ZZ(293)
finite_field = GF(prime)
finite_polynomial_ring = PolynomialRing(finite_field, "y")
y = finite_polynomial_ring.gen()
reduced_factor = finite_polynomial_ring(irreducible_factor)

assert irreducible_factor.leading_coefficient() % prime == 63
assert irreducible_factor.discriminant() % prime == 76
assert reduced_factor.is_squarefree()

expected_factors = [
    y + 281,
    y^12 + 12*y^11 + 27*y^10 + 197*y^9 + 133*y^8 + 68*y^7
    + 188*y^6 + 285*y^5 + 31*y^4 + 209*y^3 + 70*y^2 + 114*y + 36,
    y^31 + 194*y^30 + 131*y^29 + 180*y^28 + 289*y^27 + 223*y^26
    + 64*y^25 + 67*y^24 + 207*y^23 + 132*y^22 + 70*y^21 + 278*y^20
    + 136*y^19 + 82*y^18 + 102*y^17 + 101*y^16 + 236*y^15 + 118*y^14
    + 125*y^13 + 24*y^12 + 186*y^11 + 150*y^9 + 251*y^8 + 33*y^7
    + 194*y^6 + 196*y^5 + 267*y^4 + 8*y^3 + 226*y^2 + 21*y + 222,
]

assert all(factor.is_monic() for factor in expected_factors)
assert all(factor.is_irreducible() for factor in expected_factors)
assert [factor.degree() for factor in expected_factors] == [1, 12, 31]
assert reduced_factor == finite_field(63) * prod(expected_factors)

cycle_order = lcm([factor.degree() for factor in expected_factors])
assert cycle_order == 372
assert cycle_order in NN

print(
    "RESULT: PASS — modulo 293 the degree-44 factor is squarefree with "
    "irreducible degrees 1,12,31, whose cycle order is 372"
)
