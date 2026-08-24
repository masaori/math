# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: S_{G,2}(a) = R_G(a)^2-B_G(a)/Pbar_G(a)
# 帰属: 有限集合、NN、QQbar、QQbar[x] だけを用いる
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        polynomial_value = data["polynomial"](a)
        if polynomial_value != 0:
            reciprocal_sum = sum(((a - alpha)**(-1) for alpha in data["roots"]), QQbar(0))
            reciprocal_square_sum = sum(((a - alpha)**(-2) for alpha in data["roots"]), QQbar(0))
            second_coefficient_sum = data["polynomial"].derivative().derivative()(a)
            left = reciprocal_square_sum
            right = reciprocal_sum**2 - second_coefficient_sum / polynomial_value
            assert left == right, (data["name"], a)
print("RESULT: PASS — rearrangement isolates the shifted reciprocal square sum")
