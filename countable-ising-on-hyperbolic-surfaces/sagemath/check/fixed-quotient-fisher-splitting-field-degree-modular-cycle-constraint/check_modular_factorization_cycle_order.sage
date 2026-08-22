# SageMath: 次数四十四の既約因子の有限体分解型と置換位数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_modular_cycle_constraint
# 式ペア: factor degrees (1, 2, 5, 13, 23) and lcm = 2990
# 帰属: ZZ[x]、GF(107)[x]、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

prime = ZZ(107)
finite_field = GF(prime)
finite_polynomial_ring = PolynomialRing(finite_field, "y")
y = finite_polynomial_ring.gen()
reduced_factor = finite_polynomial_ring(irreducible_factor)

assert irreducible_factor.leading_coefficient() % prime == 63
assert irreducible_factor.discriminant() % prime == 43
assert reduced_factor.is_squarefree()

expected_factors = [
    y + 53,
    y^2 + 26*y + 44,
    y^5 + 45*y^4 + 22*y^3 + 12*y^2 + 21*y + 57,
    y^13 + 14*y^12 + 55*y^11 + 66*y^10 + 77*y^9 + 71*y^8
    + 16*y^7 + 40*y^6 + 32*y^5 + 79*y^4 + 100*y^3 + 103*y^2
    + 79*y + 4,
    y^23 + 39*y^22 + 40*y^21 + 16*y^20 + 25*y^19 + 36*y^18
    + 53*y^17 + 59*y^16 + 76*y^15 + 78*y^14 + 101*y^13
    + 92*y^12 + 104*y^11 + 33*y^10 + 64*y^9 + 51*y^8 + 46*y^7
    + 28*y^6 + 80*y^5 + 86*y^4 + 51*y^3 + 25*y^2 + 23*y + 26,
]

assert all(factor.is_monic() for factor in expected_factors)
assert all(factor.is_irreducible() for factor in expected_factors)
assert [factor.degree() for factor in expected_factors] == [1, 2, 5, 13, 23]
assert reduced_factor == finite_field(63) * prod(expected_factors)

cycle_order = lcm([factor.degree() for factor in expected_factors])
assert cycle_order == 2990
assert cycle_order in NN

print(
    "RESULT: PASS — modulo 107 the degree-44 factor is squarefree with "
    "irreducible degrees 1,2,5,13,23, whose cycle order is 2990"
)
