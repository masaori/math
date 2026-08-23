# SageMath: 次数四十四の既約因子の 709 進分解型と置換位数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_709_modular_cycle_constraint
# 式ペア: factor degrees (12, 32) and lcm = 96
# 帰属: ZZ[x]、GF(709)[x]、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

prime = ZZ(709)
finite_field = GF(prime)
finite_polynomial_ring = PolynomialRing(finite_field, "y")
y = finite_polynomial_ring.gen()
reduced_factor = finite_polynomial_ring(irreducible_factor)

assert irreducible_factor.leading_coefficient() % prime == 63
assert irreducible_factor.discriminant() % prime == 489
assert reduced_factor.is_squarefree()

degree_twelve_factor = (
    y^12 + 670*y^11 + 142*y^10 + 655*y^9 + 589*y^8 + 500*y^7
    + 406*y^6 + 420*y^5 + 381*y^4 + 35*y^3 + 52*y^2 + 55*y + 127
)
degree_thirty_two_factor = (
    y^32 + 274*y^31 + 632*y^30 + 599*y^29 + 534*y^28 + 223*y^27
    + 689*y^26 + 4*y^25 + 458*y^24 + 682*y^23 + 563*y^22
    + 253*y^21 + 522*y^20 + 246*y^19 + 40*y^18 + 616*y^17
    + 111*y^16 + 164*y^15 + 189*y^14 + 459*y^13 + 567*y^12
    + 409*y^11 + 340*y^10 + 85*y^9 + 345*y^8 + 680*y^7
    + 635*y^6 + 226*y^5 + 159*y^4 + 220*y^3 + 271*y^2
    + 266*y + 530
)
expected_factors = [degree_twelve_factor, degree_thirty_two_factor]

assert all(factor.is_monic() for factor in expected_factors)
assert all(factor.is_irreducible() for factor in expected_factors)
assert [factor.degree() for factor in expected_factors] == [12, 32]
assert reduced_factor == finite_field(63) * prod(expected_factors)

cycle_order = lcm([factor.degree() for factor in expected_factors])
assert cycle_order == 96
assert cycle_order in NN

print(
    "RESULT: PASS — modulo 709 the degree-44 factor is squarefree with "
    "irreducible degrees 12,32, whose cycle order is 96"
)
