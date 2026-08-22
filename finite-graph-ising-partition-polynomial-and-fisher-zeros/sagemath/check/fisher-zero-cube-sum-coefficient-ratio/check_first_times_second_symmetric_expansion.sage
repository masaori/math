# 対象ラベル: theorem_fisher_zero_cube_sum_coefficient_ratio
# 式ペア: e1 e2 = s_(2,1) + 3 e3

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    assert elementary(roots, 1) * elementary(roots, 2) == repeated_pair_sum(roots) + 3 * elementary(roots, 3), data["name"]

print("RESULT: PASS — multiplying the first two elementary symmetric sums separates repeated and distinct indices")
