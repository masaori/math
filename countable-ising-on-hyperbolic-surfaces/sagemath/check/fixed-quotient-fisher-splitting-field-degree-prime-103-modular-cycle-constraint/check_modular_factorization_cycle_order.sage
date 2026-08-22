# SageMath: 次数四十四の既約因子の 103 進分解型と置換位数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_103_modular_cycle_constraint
# 式ペア: factor degrees (2, 4, 9, 29) and lcm = 1044
# 帰属: ZZ[x]、GF(103)[x]、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

prime = ZZ(103)
finite_field = GF(prime)
finite_polynomial_ring = PolynomialRing(finite_field, "y")
y = finite_polynomial_ring.gen()
reduced_factor = finite_polynomial_ring(irreducible_factor)

assert irreducible_factor.leading_coefficient() % prime == 63
assert irreducible_factor.discriminant() % prime == 98
assert reduced_factor.is_squarefree()

expected_factors = [
    y^2 + 51*y + 91,
    y^4 + 36*y^3 + 20*y^2 + 98*y + 84,
    y^9 + 101*y^8 + 88*y^7 + y^6 + 48*y^5 + 76*y^4
    + 36*y^3 + 60*y^2 + 23*y + 69,
    y^29 + 51*y^28 + 101*y^27 + 18*y^26 + 26*y^25 + 40*y^24
    + 15*y^23 + 79*y^22 + 61*y^21 + 93*y^20 + 21*y^19
    + 29*y^18 + 96*y^17 + 62*y^16 + 52*y^15 + 61*y^14
    + 53*y^13 + 86*y^12 + 4*y^11 + 73*y^10 + 7*y^9
    + 101*y^8 + y^7 + 20*y^6 + 77*y^5 + 2*y^4 + 5*y^3
    + 84*y^2 + 92*y + 68,
]

assert all(factor.is_monic() for factor in expected_factors)
assert all(factor.is_irreducible() for factor in expected_factors)
assert [factor.degree() for factor in expected_factors] == [2, 4, 9, 29]
assert reduced_factor == finite_field(63) * prod(expected_factors)

cycle_order = lcm([factor.degree() for factor in expected_factors])
assert cycle_order == 1044
assert cycle_order in NN

print(
    "RESULT: PASS — modulo 103 the degree-44 factor is squarefree with "
    "irreducible degrees 2,4,9,29, whose cycle order is 1044"
)
