# 対象ラベル: theorem_reciprocal_fisher_zero_cube_sum_coefficient_ratio
# 式ペア: e1hat e2hat = s21hat + 3 e3hat

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    left = reciprocal_elementary(roots, 1) * reciprocal_elementary(roots, 2)
    right = reciprocal_repeated_pair_sum(roots) + 3 * reciprocal_elementary(roots, 3)
    assert left == right, data["name"]

print("RESULT: PASS — the first-times-second reciprocal symmetric expansion separates exactly")
