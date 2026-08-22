# 対象ラベル: theorem_fisher_zero_fourth_power_sum_coefficient_ratio
# 式ペア: e2 p2 = s_(3,1) + s_(2,1,1)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-fourth-power-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    assert elementary(roots, 2) * power_sum(roots, 2) == three_one_sum(roots) + two_one_one_sum(roots), data["name"]

print("RESULT: PASS — multiplying the second symmetric sum by the square sum separates inside and outside indices")
