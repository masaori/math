# SageMath: 次数四十四の既約因子の 131 進分解型と置換位数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_131_modular_cycle_constraint
# 式ペア: factor degrees (1, 2, 41) and lcm = 82
# 帰属: ZZ[x]、GF(131)[x]、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

prime = ZZ(131)
finite_field = GF(prime)
finite_polynomial_ring = PolynomialRing(finite_field, "y")
y = finite_polynomial_ring.gen()
reduced_factor = finite_polynomial_ring(irreducible_factor)

assert irreducible_factor.leading_coefficient() % prime == 63
assert irreducible_factor.discriminant() % prime == 18
assert reduced_factor.is_squarefree()

expected_factors = [
    y + 7,
    y^2 + 46*y + 6,
    y^41 + 33*y^40 + 33*y^39 + 8*y^38 + 73*y^37 + 30*y^36
    + 68*y^35 + 28*y^34 + 12*y^33 + 116*y^32 + 112*y^31
    + 87*y^30 + 124*y^29 + 128*y^28 + 85*y^27 + 74*y^26
    + 114*y^25 + 28*y^24 + 6*y^23 + 7*y^22 + 55*y^21
    + 101*y^20 + 126*y^19 + 106*y^18 + 13*y^17 + 42*y^16
    + 3*y^15 + 21*y^14 + 65*y^13 + 63*y^12 + 52*y^11
    + 17*y^10 + 11*y^9 + 62*y^8 + 79*y^7 + 28*y^6 + 90*y^5
    + 33*y^4 + 123*y^3 + 117*y^2 + 124*y + 126,
]

assert all(factor.is_monic() for factor in expected_factors)
assert all(factor.is_irreducible() for factor in expected_factors)
assert [factor.degree() for factor in expected_factors] == [1, 2, 41]
assert reduced_factor == finite_field(63) * prod(expected_factors)

cycle_order = lcm([factor.degree() for factor in expected_factors])
assert cycle_order == 82
assert cycle_order in NN

print(
    "RESULT: PASS — modulo 131 the degree-44 factor is squarefree with "
    "irreducible degrees 1,2,41, whose cycle order is 82"
)
