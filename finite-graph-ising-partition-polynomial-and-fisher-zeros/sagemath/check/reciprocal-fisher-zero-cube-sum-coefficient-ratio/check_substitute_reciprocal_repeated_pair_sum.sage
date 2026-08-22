# 対象ラベル: theorem_reciprocal_fisher_zero_cube_sum_coefficient_ratio
# 式ペア: s21hat = e1hat e2hat - 3 e3hat

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    left = reciprocal_repeated_pair_sum(roots)
    right = reciprocal_elementary(roots, 1) * reciprocal_elementary(roots, 2) - 3 * reciprocal_elementary(roots, 3)
    assert left == right, data["name"]

print("RESULT: PASS — the reciprocal repeated-pair sum is replaced by symmetric expressions")
