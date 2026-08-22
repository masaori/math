# 対象ラベル: theorem_fisher_zero_square_sum_coefficient_ratio
# 式ペア: (sum alpha)^2 - 2 sum_{i<j} alpha_i alpha_j = (-Omega(d-1)/Omega(d))^2 - 2 Omega(d-2)/Omega(d)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-square-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    polynomial = data["polynomial"]
    degree = data["degree"]
    leading = QQ(polynomial[degree])
    next_coefficient = QQ(polynomial[degree - 1])
    second_next_coefficient = QQ(polynomial[degree - 2])
    left = sum(roots, QQbar(0))**2 - 2 * root_pair_sum(roots)
    right = (-next_coefficient / leading)**2 - 2 * second_next_coefficient / leading
    assert left == QQbar(right), data["name"]

print("RESULT: PASS — the first two elementary symmetric coefficient ratios substitute exactly")
