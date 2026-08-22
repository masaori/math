# 対象ラベル: theorem_fisher_zero_fourth_power_sum_coefficient_ratio
# 式ペア: p4 = e1 p3 - e2 p2 + e3 p1 - 4 e4

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-fourth-power-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    right = (elementary(roots, 1) * power_sum(roots, 3)
             - elementary(roots, 2) * power_sum(roots, 2)
             + elementary(roots, 3) * power_sum(roots, 1)
             - 4 * elementary(roots, 4))
    assert power_sum(roots, 4) == right, data["name"]

print("RESULT: PASS — removing the final parentheses gives the fourth Newton identity")
