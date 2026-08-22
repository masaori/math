# 対象ラベル: theorem_reciprocal_fisher_zero_fourth_power_sum_coefficient_ratio
# 式ペア: e1 p3 - (e2 p2 - s) = e1 p3 - e2 p2 + s
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-fourth-power-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    roots = data["roots"]
    e1, e2 = elementary(roots, 1), elementary(roots, 2)
    p2, p3 = power_sum(roots, 2), power_sum(roots, 3)
    repeated = two_one_one_sum(roots)
    assert e1 * p3 - (e2 * p2 - repeated) == e1 * p3 - e2 * p2 + repeated, data["name"]
print("RESULT: PASS — distributivity expands the reciprocal three-one substitution")
