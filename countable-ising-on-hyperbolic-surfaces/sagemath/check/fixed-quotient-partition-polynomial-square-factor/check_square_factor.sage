# SageMath: 固定剰余類格子の Ising 分配多項式の平方因子判定
# 対象ラベル: theorem_fixed_quotient_partition_polynomial_has_square_factor
# 帰属: ZZ、QQ[x] だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-ising-partition-polynomial/_prelude.sage",
    )
)

polynomial_ring = PolynomialRing(QQ, "x")
partition_polynomial = polynomial_ring(expected_coefficients)
formal_derivative = partition_polynomial.derivative()

even_coefficient_sum = sum(
    expected_coefficients[degree]
    for degree in range(0, 57, 2)
)
odd_coefficient_sum = sum(
    expected_coefficients[degree]
    for degree in range(1, 57, 2)
)
odd_weighted_sum = sum(
    degree * expected_coefficients[degree]
    for degree in range(1, 57, 2)
)
even_weighted_sum = sum(
    degree * expected_coefficients[degree]
    for degree in range(2, 57, 2)
)

assert partition_polynomial.degree() == 56
assert even_coefficient_sum == ZZ(8388608)
assert odd_coefficient_sum == ZZ(8388608)
assert partition_polynomial(-1) == even_coefficient_sum - odd_coefficient_sum
assert partition_polynomial(-1) == 0

assert odd_weighted_sum == ZZ(352321536)
assert even_weighted_sum == ZZ(352321536)
assert formal_derivative(-1) == odd_weighted_sum - even_weighted_sum
assert formal_derivative(-1) == 0

x = polynomial_ring.gen()
common_divisor = gcd(partition_polynomial, formal_derivative)
assert (x + 1).divides(partition_polynomial)
assert (x + 1).divides(formal_derivative)
assert common_divisor.degree() >= 1
assert common_divisor != 1
assert not partition_polynomial.is_squarefree()

integer_polynomial_ring = PolynomialRing(ZZ, "x")
integer_x = integer_polynomial_ring.gen()
integer_partition_polynomial = integer_polynomial_ring(expected_coefficients)
integer_square_factor = (integer_x + 1)^2
assert integer_square_factor.divides(integer_partition_polynomial)

print(
    "RESULT: PASS — exact QQ[x] arithmetic shows x+1 divides both the fixed "
    "partition polynomial and its formal derivative, so their gcd is nonconstant "
    "and the polynomial has a square factor"
)
