# 対象ラベル: theorem_fisher_zero_square_sum_coefficient_ratio
# 式ペア: sum_j alpha_j^2 = (sum_j alpha_j)^2 - 2 sum_{i<j} alpha_i alpha_j

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-square-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    root_sum = sum(roots, QQbar(0))
    assert root_square_sum(roots) == root_sum**2 - 2 * root_pair_sum(roots), data["name"]

print("RESULT: PASS — rearranging the finite square expansion isolates the Fisher-zero square sum")
