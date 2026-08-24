# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: R_G(a) S_{G,2}(a) = (sum_k 1/(a-alpha_k)) S_{G,2}(a)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            reciprocal_sum = reciprocal_power_sum(data, a, 1)
            reciprocal_square_sum = reciprocal_power_sum(data, a, 2)
            left = reciprocal_sum * reciprocal_square_sum
            right = sum(((a - alpha) ** (-1) for alpha in data["roots"]), QQbar(0)) * reciprocal_square_sum
            assert left == right, (data["name"], a)
print("RESULT: PASS — substituting the reciprocal-sum definition preserves the product")
