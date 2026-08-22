# SageMath: 次数四十四の既約因子の 389 進分解型と置換位数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_389_modular_cycle_constraint
# 式ペア: factor degrees (1, 43) and lcm = 43
# 帰属: ZZ[x]、GF(389)[x]、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

prime = ZZ(389)
finite_field = GF(prime)
finite_polynomial_ring = PolynomialRing(finite_field, "y")
y = finite_polynomial_ring.gen()
reduced_factor = finite_polynomial_ring(irreducible_factor)

assert irreducible_factor.leading_coefficient() % prime == 63
assert irreducible_factor.discriminant() % prime == 28
assert reduced_factor.is_squarefree()

linear_factor = y + 136
degree_forty_three_factor = (
    y^43 + 122*y^42 + 149*y^41 + 269*y^40 + 203*y^39 + 25*y^38
    + 165*y^37 + 186*y^36 + 283*y^35 + 26*y^34 + 160*y^33 + 334*y^32
    + 75*y^31 + 2*y^30 + 365*y^29 + 60*y^28 + 138*y^27 + 311*y^26
    + 196*y^25 + 123*y^24 + 58*y^23 + 158*y^22 + 109*y^21 + 76*y^20
    + 311*y^19 + 343*y^18 + 340*y^17 + 2*y^16 + 33*y^15 + 212*y^14
    + 340*y^13 + 268*y^12 + 294*y^11 + 168*y^10 + 117*y^9 + 241*y^8
    + 206*y^7 + 80*y^6 + 122*y^5 + 325*y^4 + 38*y^3 + 229*y^2
    + 181*y + 39
)
expected_factors = [linear_factor, degree_forty_three_factor]

assert all(factor.is_monic() for factor in expected_factors)
assert all(factor.is_irreducible() for factor in expected_factors)
assert [factor.degree() for factor in expected_factors] == [1, 43]
assert reduced_factor == finite_field(63) * prod(expected_factors)

cycle_order = lcm([factor.degree() for factor in expected_factors])
assert cycle_order == 43
assert cycle_order in NN

print(
    "RESULT: PASS — modulo 389 the degree-44 factor is squarefree with "
    "irreducible degrees 1,43, whose cycle order is 43"
)
