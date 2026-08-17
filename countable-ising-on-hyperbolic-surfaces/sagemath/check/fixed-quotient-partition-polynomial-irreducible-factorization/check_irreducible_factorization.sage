# SageMath: 固定剰余類格子の Ising 分配多項式の既約分解
# 対象ラベル: theorem_fixed_quotient_partition_polynomial_irreducible_factorization
# 帰属: ZZ[x] と GF(191)[x] だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-ising-partition-polynomial/_prelude.sage",
    )
)

integer_polynomial_ring = PolynomialRing(ZZ, "x")
x = integer_polynomial_ring.gen()
partition_polynomial = integer_polynomial_ring(expected_coefficients)

irreducible_factor = (
    63*x^44 - 84*x^43 + 882*x^42 - 5292*x^41 + 30261*x^40 - 124376*x^39
    + 396144*x^38 - 1022928*x^37 + 2256050*x^36 - 4400568*x^35
    + 7781004*x^34 - 12653312*x^33 + 19098240*x^32 - 26919480*x^31
    + 35607568*x^30 - 44375136*x^29 + 52275723*x^28 - 58374540*x^27
    + 61934922*x^26 - 62562108*x^25 + 60269153*x^24 - 55450752*x^23
    + 48781656*x^22 - 41071744*x^21 + 33118029*x^20 - 25586652*x^19
    + 18944254*x^18 - 13441092*x^17 + 9135819*x^16 - 5945016*x^15
    + 3700368*x^14 - 2200128*x^13 + 1247330*x^12 - 672672*x^11
    + 343980*x^10 - 166088*x^9 + 75294*x^8 - 31800*x^7 + 12376*x^6
    - 4368*x^5 + 1365*x^4 - 364*x^3 + 78*x^2 - 12*x + 1
)

assert partition_polynomial == 2 * (x + 1)^12 * irreducible_factor
assert irreducible_factor.degree() == 44
assert irreducible_factor.content() == 1

finite_field = GF(191)
finite_polynomial_ring = PolynomialRing(finite_field, "x")
finite_x = finite_polynomial_ring.gen()
reduced_factor = finite_polynomial_ring(irreducible_factor)

assert reduced_factor.degree() == 44
assert power_mod(finite_x, 191^44, reduced_factor) == finite_x
assert gcd(
    reduced_factor,
    power_mod(finite_x, 191^22, reduced_factor) - finite_x,
) == 1
assert gcd(
    reduced_factor,
    power_mod(finite_x, 191^4, reduced_factor) - finite_x,
) == 1
assert reduced_factor.is_irreducible()
assert irreducible_factor.is_irreducible()

factorization = partition_polynomial.factor()
assert factorization.prod() == partition_polynomial
assert list(factorization) == [
    (integer_polynomial_ring(2), 1),
    (x + 1, 12),
    (irreducible_factor, 1),
]

print(
    "RESULT: PASS — exact ZZ[x] reconstruction and the finite-field "
    "irreducibility criterion over GF(191) give the factorization "
    "2*(x+1)^12*Q_Q with Q_Q irreducible of degree 44"
)
