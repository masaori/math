# 対象ラベル: theorem_reciprocal_fisher_zero_fourth_power_sum_coefficient_ratio
# 式ペア: e3 p1 = s_(2,1,1) + 4 e4
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-fourth-power-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    roots = data["roots"]
    assert elementary(roots, 3) * power_sum(roots, 1) == two_one_one_sum(roots) + 4 * elementary(roots, 4), data["name"]
print("RESULT: PASS — the reciprocal-root third symmetric sum times the root sum separates index types")
