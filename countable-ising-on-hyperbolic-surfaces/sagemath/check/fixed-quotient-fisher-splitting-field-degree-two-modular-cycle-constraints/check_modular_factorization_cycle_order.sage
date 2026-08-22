# SageMath: 次数四十四の既約因子の 101 進分解型と置換位数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_two_modular_cycle_constraints
# 式ペア: factor degrees (4, 19, 21) and lcm = 1596
# 帰属: ZZ[x]、GF(101)[x]、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

prime = ZZ(101)
finite_field = GF(prime)
finite_polynomial_ring = PolynomialRing(finite_field, "y")
y = finite_polynomial_ring.gen()
reduced_factor = finite_polynomial_ring(irreducible_factor)

assert irreducible_factor.leading_coefficient() % prime == 63
assert irreducible_factor.discriminant() % prime == 18
assert reduced_factor.is_squarefree()

expected_factors = [
    y^4 + 58*y^3 + 4*y^2 + 64*y + 71,
    y^19 + 2*y^18 + 19*y^17 + 10*y^16 + 31*y^15 + 16*y^14
    + 29*y^13 + 51*y^12 + 58*y^11 + 8*y^10 + 61*y^9 + 69*y^8
    + 3*y^7 + 97*y^6 + 16*y^5 + 98*y^4 + 36*y^3 + 59*y^2
    + 12*y + 63,
    y^21 + 6*y^20 + 20*y^19 + 31*y^18 + 4*y^17 + 64*y^16
    + 68*y^15 + 82*y^14 + 82*y^13 + 24*y^12 + 44*y^11 + 46*y^10
    + 74*y^9 + 27*y^8 + 33*y^7 + 17*y^6 + 34*y^5 + 46*y^4
    + 44*y^3 + 5*y^2 + 38*y + 45,
]

assert all(factor.is_monic() for factor in expected_factors)
assert all(factor.is_irreducible() for factor in expected_factors)
assert [factor.degree() for factor in expected_factors] == [4, 19, 21]
assert reduced_factor == finite_field(63) * prod(expected_factors)

cycle_order = lcm([factor.degree() for factor in expected_factors])
assert cycle_order == 1596
assert cycle_order in NN

print(
    "RESULT: PASS — modulo 101 the degree-44 factor is squarefree with "
    "irreducible degrees 4,19,21, whose cycle order is 1596"
)
