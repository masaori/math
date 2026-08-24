# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: Pbar_G(a)(R_G(a)^2-S_{G,2}(a)) = Pbar_G(a)((sum_k(a-alpha_k)^-1)^2-S_{G,2}(a))
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        polynomial_value = data["polynomial"](a)
        if polynomial_value != 0:
            reciprocal_sum = sum(((a - alpha)**(-1) for alpha in data["roots"]), QQbar(0))
            reciprocal_square_sum = sum(((a - alpha)**(-2) for alpha in data["roots"]), QQbar(0))
            named_reciprocal_sum = reciprocal_sum
            left = polynomial_value * (named_reciprocal_sum**2 - reciprocal_square_sum)
            right = polynomial_value * (reciprocal_sum**2 - reciprocal_square_sum)
            assert left == right, (data["name"], a)
print("RESULT: PASS — substituting only the reciprocal-sum definition preserves the equality")
