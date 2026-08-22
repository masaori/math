# SageMath: 次数四十四の既約因子の 367 進分解型と置換位数
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_367_modular_cycle_constraint
# 式ペア: factor degrees (1, 1, 1, 7, 8, 10, 16) and lcm = 560
# 帰属: ZZ[x]、GF(367)[x]、NN だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage",
    )
)

prime = ZZ(367)
finite_field = GF(prime)
finite_polynomial_ring = PolynomialRing(finite_field, "y")
y = finite_polynomial_ring.gen()
reduced_factor = finite_polynomial_ring(irreducible_factor)

assert irreducible_factor.leading_coefficient() % prime == 63
assert irreducible_factor.discriminant() % prime == 48
assert reduced_factor.is_squarefree()

expected_factors = [
    y + 146,
    y + 292,
    y + 328,
    y^7 + 357*y^6 + 297*y^5 + 251*y^4 + 59*y^3 + 198*y^2 + 7*y + 25,
    y^8 + 289*y^7 + 35*y^6 + 47*y^5 + 282*y^4 + 315*y^3
    + 249*y^2 + 192*y + 365,
    y^10 + 241*y^9 + 216*y^8 + 150*y^7 + 249*y^6 + 165*y^5
    + 281*y^4 + 361*y^3 + 219*y^2 + 123*y + 226,
    y^16 + 303*y^15 + 187*y^14 + 239*y^13 + 176*y^12 + 212*y^11
    + 336*y^10 + 110*y^9 + 168*y^8 + 26*y^7 + 84*y^6 + 177*y^5
    + 116*y^4 + 19*y^3 + 329*y^2 + 77*y + 159,
]

assert all(factor.is_monic() for factor in expected_factors)
assert all(factor.is_irreducible() for factor in expected_factors)
assert [factor.degree() for factor in expected_factors] == [1, 1, 1, 7, 8, 10, 16]
assert reduced_factor == finite_field(63) * prod(expected_factors)

cycle_order = lcm([factor.degree() for factor in expected_factors])
assert cycle_order == 560
assert cycle_order in NN

print(
    "RESULT: PASS — modulo 367 the degree-44 factor is squarefree with "
    "irreducible degrees 1,1,1,7,8,10,16, whose cycle order is 560"
)
