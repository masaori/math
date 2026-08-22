# 対象ラベル: theorem_reciprocal_fisher_zero_square_sum_coefficient_ratio
# 式ペア: (-Omega(1)/Omega(0))^2 - 2 Omega(2)/Omega(0) = Omega(1)^2/Omega(0)^2 - 2 Omega(2)/Omega(0)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-square-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial = data["polynomial"]
    constant = QQ(polynomial[0])
    linear = QQ(polynomial[1])
    quadratic = QQ(polynomial[2])
    left = (-linear / constant)**2 - 2 * quadratic / constant
    right = linear**2 / constant**2 - 2 * quadratic / constant
    assert left == right, data["name"]

print("RESULT: PASS — squaring the negative low-coefficient quotient removes the sign exactly")
