# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: sum_j(a-alpha_j)^-2 = (A_G(a)^2-Pbar_G(a)B_G(a))/Pbar_G(a)^2
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        polynomial_value = data["polynomial"](a)
        if polynomial_value != 0:
            reciprocal_square_sum = sum(((a - alpha)**(-2) for alpha in data["roots"]), QQbar(0))
            first_coefficient_sum = sum(
                (
                    QQbar(exponent * data["multiplicities"][exponent]) * a ** (exponent - 1)
                    for exponent in range(1, data["edge_count"] + 1)
                ),
                QQbar(0),
            )
            second_coefficient_sum = sum(
                (
                    QQbar(exponent * (exponent - 1) * data["multiplicities"][exponent])
                    * a ** (exponent - 2)
                    for exponent in range(2, data["edge_count"] + 1)
                ),
                QQbar(0),
            )
            coefficient_ratio = (
                first_coefficient_sum**2 - polynomial_value * second_coefficient_sum
            ) / polynomial_value**2
            assert reciprocal_square_sum == coefficient_ratio, (data["name"], a)
print("RESULT: PASS — the shifted reciprocal square sum equals the finite second-derivative coefficient ratio")
