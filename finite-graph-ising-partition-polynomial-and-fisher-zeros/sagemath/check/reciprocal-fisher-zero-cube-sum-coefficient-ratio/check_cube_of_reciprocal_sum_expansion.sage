# 対象ラベル: theorem_reciprocal_fisher_zero_cube_sum_coefficient_ratio
# 式ペア: e1hat^3 = sum(alpha_j^-3) + 3 s21hat + 6 e3hat

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    left = reciprocal_elementary(roots, 1)**3
    right = reciprocal_cube_sum(roots) + 3 * reciprocal_repeated_pair_sum(roots) + 6 * reciprocal_elementary(roots, 3)
    assert left == right, data["name"]

print("RESULT: PASS — the reciprocal-root sum cube separates by index coincidence type")
