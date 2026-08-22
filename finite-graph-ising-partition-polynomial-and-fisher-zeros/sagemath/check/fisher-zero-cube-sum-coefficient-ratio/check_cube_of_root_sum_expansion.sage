# 対象ラベル: theorem_fisher_zero_cube_sum_coefficient_ratio
# 式ペア: e1^3 = sum_j alpha_j^3 + 3 s_(2,1) + 6 e3

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    e1 = elementary(roots, 1)
    e3 = elementary(roots, 3)
    assert e1**3 == cube_sum(roots) + 3 * repeated_pair_sum(roots) + 6 * e3, data["name"]

print("RESULT: PASS — the finite cube expansion separates equal, repeated, and distinct indices")
