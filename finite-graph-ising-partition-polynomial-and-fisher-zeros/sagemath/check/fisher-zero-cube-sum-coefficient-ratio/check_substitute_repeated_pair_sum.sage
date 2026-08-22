# 対象ラベル: theorem_fisher_zero_cube_sum_coefficient_ratio
# 式ペア: e1^3 - 3 s_(2,1) - 6 e3 = e1^3 - 3(e1 e2 - 3e3) - 6e3

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    e1, e2, e3 = (elementary(roots, order) for order in (1, 2, 3))
    left = e1**3 - 3 * repeated_pair_sum(roots) - 6 * e3
    right = e1**3 - 3 * (e1 * e2 - 3 * e3) - 6 * e3
    assert left == right, data["name"]

print("RESULT: PASS — the repeated-index sum is replaced by e1 e2 minus three e3")
