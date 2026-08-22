# 対象ラベル: theorem_fisher_zero_fourth_power_sum_coefficient_ratio
# 式ペア: e1 p3 = p4 + s_(3,1)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-fourth-power-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    assert elementary(roots, 1) * power_sum(roots, 3) == power_sum(roots, 4) + three_one_sum(roots), data["name"]

print("RESULT: PASS — multiplying the first symmetric sum by the cube sum separates equal and distinct indices")
