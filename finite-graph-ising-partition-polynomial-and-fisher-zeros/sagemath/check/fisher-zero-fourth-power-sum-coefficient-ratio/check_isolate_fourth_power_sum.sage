# 対象ラベル: theorem_fisher_zero_fourth_power_sum_coefficient_ratio
# 式ペア: p4 = e1 p3 - s_(3,1)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-fourth-power-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    assert power_sum(roots, 4) == elementary(roots, 1) * power_sum(roots, 3) - three_one_sum(roots), data["name"]

print("RESULT: PASS — rearranging the first finite-sum identity isolates the fourth-power sum")
