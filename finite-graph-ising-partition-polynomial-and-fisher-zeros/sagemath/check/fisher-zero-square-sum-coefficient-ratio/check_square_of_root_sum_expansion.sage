# 対象ラベル: theorem_fisher_zero_square_sum_coefficient_ratio
# 式ペア: (sum_j alpha_j)^2 = sum_j alpha_j^2 + 2 sum_{i<j} alpha_i alpha_j

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-square-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    root_sum = sum(roots, QQbar(0))
    assert root_sum**2 == root_square_sum(roots) + 2 * root_pair_sum(roots), data["name"]

print("RESULT: PASS — finite distributivity expands the squared Fisher-zero sum into square and pair terms")
