# SageMath: 次数四十四の既約因子の 163 進分解型と置換位数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_163_modular_cycle_constraint
# 式ペア: factor degrees (1, 6, 37) and lcm = 222
# 帰属: ZZ[x]、GF(163)[x]、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

prime = ZZ(163)
finite_field = GF(prime)
finite_polynomial_ring = PolynomialRing(finite_field, "y")
y = finite_polynomial_ring.gen()
reduced_factor = finite_polynomial_ring(irreducible_factor)

assert irreducible_factor.leading_coefficient() % prime == 63
assert irreducible_factor.discriminant() % prime == 2
assert reduced_factor.is_squarefree()

expected_factors = [
    y + 123,
    y^6 + 126*y^5 + 138*y^4 + 77*y^3 + 109*y^2 + 31*y + 55,
    y^37 + 130*y^36 + 93*y^35 + 62*y^34 + 3*y^33 + 110*y^32
    + 10*y^31 + 127*y^30 + 2*y^29 + 70*y^28 + 16*y^27 + 21*y^26
    + 70*y^25 + 9*y^24 + 140*y^23 + 90*y^22 + 30*y^21 + 158*y^20
    + 93*y^19 + 25*y^18 + 135*y^17 + 74*y^16 + 38*y^15 + 68*y^14
    + 40*y^13 + 105*y^12 + 66*y^11 + 15*y^10 + 146*y^9 + 130*y^8
    + 95*y^7 + 108*y^6 + 23*y^5 + 132*y^4 + 156*y^3 + 11*y^2
    + 5*y + 88,
]

assert all(factor.is_monic() for factor in expected_factors)
assert all(factor.is_irreducible() for factor in expected_factors)
assert [factor.degree() for factor in expected_factors] == [1, 6, 37]
assert reduced_factor == finite_field(63) * prod(expected_factors)

cycle_order = lcm([factor.degree() for factor in expected_factors])
assert cycle_order == 222
assert cycle_order in NN

print(
    "RESULT: PASS — modulo 163 the degree-44 factor is squarefree with "
    "irreducible degrees 1,6,37, whose cycle order is 222"
)
