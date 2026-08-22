# 対象ラベル: theorem_reciprocal_fisher_zero_fourth_power_sum_coefficient_ratio
# 式ペア: fourth Newton identity with reciprocal symmetric sums and lower power sums replaced by low-degree coefficient ratios
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-fourth-power-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    roots, polynomial = data["roots"], data["polynomial"]
    B, A1, A2, A3, A4 = (QQ(polynomial[offset]) for offset in range(5))
    left = elementary(roots, 1) * power_sum(roots, 3) - elementary(roots, 2) * power_sum(roots, 2) + elementary(roots, 3) * power_sum(roots, 1) - 4 * elementary(roots, 4)
    right = ((-A1 / B) * (-A1**3 + 3 * B * A1 * A2 - 3 * B**2 * A3) / B**3
             - (A2 / B) * (A1**2 - 2 * B * A2) / B**2
             + (-A3 / B) * (-A1 / B)
             - 4 * A4 / B)
    assert left == QQbar(right), data["name"]
print("RESULT: PASS — reciprocal symmetric sums and lower power sums are replaced by low-degree coefficient ratios")
