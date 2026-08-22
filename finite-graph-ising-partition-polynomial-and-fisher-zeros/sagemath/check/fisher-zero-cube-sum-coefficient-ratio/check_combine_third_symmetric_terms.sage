# 対象ラベル: theorem_fisher_zero_cube_sum_coefficient_ratio
# 式ペア: e1^3 - 3e1e2 + 9e3 - 6e3 = e1^3 - 3e1e2 + 3e3

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    e1, e2, e3 = (elementary(roots, order) for order in (1, 2, 3))
    assert e1**3 - 3 * e1 * e2 + 9 * e3 - 6 * e3 == e1**3 - 3 * e1 * e2 + 3 * e3, data["name"]

print("RESULT: PASS — the two third-symmetric terms combine to three e3")
