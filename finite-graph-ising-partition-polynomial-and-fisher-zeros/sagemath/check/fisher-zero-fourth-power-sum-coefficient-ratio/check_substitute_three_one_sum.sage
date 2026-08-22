# 対象ラベル: theorem_fisher_zero_fourth_power_sum_coefficient_ratio
# 式ペア: e1 p3 - s_(3,1) = e1 p3 - (e2 p2 - s_(2,1,1))

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-fourth-power-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    left = elementary(roots, 1) * power_sum(roots, 3) - three_one_sum(roots)
    right = elementary(roots, 1) * power_sum(roots, 3) - (elementary(roots, 2) * power_sum(roots, 2) - two_one_one_sum(roots))
    assert left == right, data["name"]

print("RESULT: PASS — the three-one sum is replaced by the second finite-sum identity")
