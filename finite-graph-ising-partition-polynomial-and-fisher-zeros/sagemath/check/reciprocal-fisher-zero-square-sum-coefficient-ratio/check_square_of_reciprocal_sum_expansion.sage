# 対象ラベル: theorem_reciprocal_fisher_zero_square_sum_coefficient_ratio
# 式ペア: (sum_j alpha_j^-1)^2 = sum_j alpha_j^-2 + 2 sum_{i<j} alpha_i^-1 alpha_j^-1

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-square-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    reciprocal_sum = sum((alpha**(-1) for alpha in roots), QQbar(0))
    assert reciprocal_sum**2 == reciprocal_square_sum(roots) + 2 * reciprocal_pair_sum(roots), data["name"]

print("RESULT: PASS — finite distributivity expands the squared reciprocal Fisher-zero sum")
