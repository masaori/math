# 対象ラベル: theorem_reciprocal_fisher_zero_cube_sum_coefficient_ratio
# 式ペア: e1hat^3 - 3e1hat e2hat + 3e3hat = (-A/B)^3 - 3(-A/B)(C/B) + 3(-D/B)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots, polynomial = data["roots"], data["polynomial"]
    constant, first, second, third = (QQ(polynomial[offset]) for offset in range(4))
    left = reciprocal_elementary(roots, 1)**3 - 3 * reciprocal_elementary(roots, 1) * reciprocal_elementary(roots, 2) + 3 * reciprocal_elementary(roots, 3)
    right = (-first / constant)**3 - 3 * (-first / constant) * (second / constant) + 3 * (-third / constant)
    assert left == QQbar(right), data["name"]

print("RESULT: PASS — the first three reciprocal symmetric coefficient ratios substitute exactly")
