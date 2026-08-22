# 対象ラベル: theorem_fisher_zero_cube_sum_coefficient_ratio
# 式ペア: e1^3 - 3e1e2 + 3e3 = (-A/B)^3 - 3(-A/B)(C/B) + 3(-D/B)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots, polynomial, degree = data["roots"], data["polynomial"], data["degree"]
    leading, first, second, third = (QQ(polynomial[degree - offset]) for offset in range(4))
    left = elementary(roots, 1)**3 - 3 * elementary(roots, 1) * elementary(roots, 2) + 3 * elementary(roots, 3)
    right = (-first / leading)**3 - 3 * (-first / leading) * (second / leading) + 3 * (-third / leading)
    assert left == QQbar(right), data["name"]

print("RESULT: PASS — the first three elementary symmetric coefficient ratios substitute exactly")
