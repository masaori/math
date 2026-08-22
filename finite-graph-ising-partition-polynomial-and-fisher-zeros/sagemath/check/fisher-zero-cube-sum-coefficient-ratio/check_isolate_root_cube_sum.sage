# 対象ラベル: theorem_fisher_zero_cube_sum_coefficient_ratio
# 式ペア: sum_j alpha_j^3 = e1^3 - 3 s_(2,1) - 6 e3

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    right = elementary(roots, 1)**3 - 3 * repeated_pair_sum(roots) - 6 * elementary(roots, 3)
    assert cube_sum(roots) == right, data["name"]

print("RESULT: PASS — rearranging the cube expansion isolates the Fisher-zero cube sum")
