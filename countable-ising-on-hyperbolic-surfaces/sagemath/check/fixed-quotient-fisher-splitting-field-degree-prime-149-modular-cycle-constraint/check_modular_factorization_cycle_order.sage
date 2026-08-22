# SageMath: 次数四十四の既約因子の 149 進分解型と置換位数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_149_modular_cycle_constraint
# 式ペア: factor degrees (1, 2, 2, 4, 5, 5, 25) and lcm = 100
# 帰属: ZZ[x]、GF(149)[x]、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

prime = ZZ(149)
finite_field = GF(prime)
finite_polynomial_ring = PolynomialRing(finite_field, "y")
y = finite_polynomial_ring.gen()
reduced_factor = finite_polynomial_ring(irreducible_factor)

assert irreducible_factor.leading_coefficient() % prime == 63
assert irreducible_factor.discriminant() % prime == 57
assert reduced_factor.is_squarefree()

expected_factors = [
    y + 78,
    y^2 + 16*y + 74,
    y^2 + 144*y + 145,
    y^4 + 28*y^3 + 10*y^2 + 82*y + 58,
    y^5 + 32*y^4 + 115*y^3 + 134*y^2 + 61*y + 51,
    y^5 + 58*y^4 + 62*y^3 + 9*y^2 + 7*y + 142,
    y^25 + 40*y^24 + 108*y^23 + 120*y^22 + 76*y^21 + 81*y^20
    + 41*y^19 + 54*y^18 + 143*y^17 + 46*y^16 + 59*y^15 + 94*y^14
    + 55*y^13 + 62*y^12 + 26*y^11 + 139*y^10 + 136*y^9 + 43*y^8
    + 97*y^7 + 78*y^6 + 49*y^5 + 34*y^4 + 146*y^2 + 104*y + 144,
]

assert all(factor.is_monic() for factor in expected_factors)
assert all(factor.is_irreducible() for factor in expected_factors)
assert [factor.degree() for factor in expected_factors] == [1, 2, 2, 4, 5, 5, 25]
assert reduced_factor == finite_field(63) * prod(expected_factors)

cycle_order = lcm([factor.degree() for factor in expected_factors])
assert cycle_order == 100
assert cycle_order in NN

print(
    "RESULT: PASS — modulo 149 the degree-44 factor is squarefree with "
    "irreducible degrees 1,2,2,4,5,5,25, whose cycle order is 100"
)
