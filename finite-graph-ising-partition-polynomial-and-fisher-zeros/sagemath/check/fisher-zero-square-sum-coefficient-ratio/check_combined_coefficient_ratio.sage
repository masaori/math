# 対象ラベル: theorem_fisher_zero_square_sum_coefficient_ratio
# 式ペア: A^2/B^2 - 2BC/B^2 = (A^2 - 2BC)/B^2

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-square-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial = data["polynomial"]
    degree = data["degree"]
    leading = QQ(polynomial[degree])
    next_coefficient = QQ(polynomial[degree - 1])
    second_next_coefficient = QQ(polynomial[degree - 2])
    left = next_coefficient**2 / leading**2 - 2 * leading * second_next_coefficient / leading**2
    right = (next_coefficient**2 - 2 * leading * second_next_coefficient) / leading**2
    assert left == right, data["name"]

print("RESULT: PASS — combining equal denominators gives the Fisher-zero square-sum coefficient ratio")
