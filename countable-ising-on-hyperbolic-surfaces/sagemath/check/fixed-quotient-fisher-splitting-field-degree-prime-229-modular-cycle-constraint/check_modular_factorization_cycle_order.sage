# SageMath: 次数四十四の既約因子の 229 進分解型と置換位数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_229_modular_cycle_constraint
# 式ペア: factor degrees (1, 3, 13, 27) and lcm = 351
# 帰属: ZZ[x]、GF(229)[x]、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

prime = ZZ(229)
finite_field = GF(prime)
finite_polynomial_ring = PolynomialRing(finite_field, "y")
y = finite_polynomial_ring.gen()
reduced_factor = finite_polynomial_ring(irreducible_factor)

assert irreducible_factor.leading_coefficient() % prime == 63
assert irreducible_factor.discriminant() % prime == 83
assert reduced_factor.is_squarefree()

expected_factors = [
    y + 17,
    y^3 + 67*y^2 + 69*y + 175,
    y^13 + 77*y^12 + 60*y^11 + 48*y^10 + 4*y^9 + 75*y^8
    + 221*y^7 + 168*y^6 + 54*y^5 + 170*y^4 + 168*y^3
    + 24*y^2 + 54*y + 174,
    y^27 + 143*y^26 + 170*y^25 + 11*y^24 + 127*y^23 + 48*y^22
    + 91*y^21 + 2*y^20 + 22*y^19 + 141*y^18 + 188*y^17
    + 117*y^16 + 146*y^15 + 212*y^14 + 47*y^13 + 152*y^12
    + 200*y^11 + 166*y^10 + 10*y^9 + 25*y^8 + 171*y^7
    + 165*y^6 + 74*y^5 + 17*y^4 + 148*y^3 + 96*y^2 + 3*y + 42,
]

assert all(factor.is_monic() for factor in expected_factors)
assert all(factor.is_irreducible() for factor in expected_factors)
assert [factor.degree() for factor in expected_factors] == [1, 3, 13, 27]
assert reduced_factor == finite_field(63) * prod(expected_factors)

cycle_order = lcm([factor.degree() for factor in expected_factors])
assert cycle_order == 351
assert cycle_order in NN

print(
    "RESULT: PASS — modulo 229 the degree-44 factor is squarefree with "
    "irreducible degrees 1,3,13,27, whose cycle order is 351"
)
