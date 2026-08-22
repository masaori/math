# 対象ラベル: theorem_reciprocal_fisher_zero_square_sum_coefficient_ratio
# 式ペア: A^2/B^2 - 2BC/B^2 = (A^2 - 2BC)/B^2

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-square-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial = data["polynomial"]
    constant = QQ(polynomial[0])
    linear = QQ(polynomial[1])
    quadratic = QQ(polynomial[2])
    left = linear**2 / constant**2 - 2 * constant * quadratic / constant**2
    right = (linear**2 - 2 * constant * quadratic) / constant**2
    assert left == right, data["name"]

print("RESULT: PASS — combining equal denominators gives the reciprocal square-sum coefficient ratio")
