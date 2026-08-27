# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: sum_j 1/(a-alpha_j)^3 = S_{G,3}(a) と S_{G,3}(a) = N_G(a)/(q_2 Pbar_G(a)^3) の推移律
# 帰属: a, alpha_j, S_{G,3}(a), N_G(a)/(q_2 Pbar_G(a)^3) は QQbar に属する
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        polynomial_value = data["polynomial"](a)
        if polynomial_value != 0:
            displayed_sum = sum(
                ((a - alpha) ** (-3) for alpha in data["roots"]),
                QQbar(0),
            )
            local_sum = reciprocal_power_sum(data, a, 3)
            first_coefficient_sum = coefficient_sum(data, a, 1)
            second_coefficient_sum = coefficient_sum(data, a, 2)
            third_coefficient_sum = coefficient_sum(data, a, 3)
            coefficient_ratio = (
                q2 * first_coefficient_sum**3
                - q3 * polynomial_value * first_coefficient_sum * second_coefficient_sum
                + polynomial_value**2 * third_coefficient_sum
            ) / (q2 * polynomial_value**3)
            assert displayed_sum == local_sum, (data["name"], a)
            assert local_sum == coefficient_ratio, (data["name"], a)
            assert displayed_sum == coefficient_ratio, (data["name"], a)
print("RESULT: PASS — transitivity returns the local reciprocal cube sum to the theorem statement")
