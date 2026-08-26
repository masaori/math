# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: C_G(a)/Pbar_G(a) = R_G(a)^3-q_3 R_G(a)S_{G,2}(a)+q_2S_{G,3}(a)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        polynomial_value = data["polynomial"](a)
        if polynomial_value != 0:
            left = coefficient_sum(data, a, 3) / polynomial_value
            middle = ordered_distinct_triple_sum(data, a)
            reciprocal_sum = reciprocal_power_sum(data, a, 1)
            reciprocal_square_sum = reciprocal_power_sum(data, a, 2)
            reciprocal_cube_sum = reciprocal_power_sum(data, a, 3)
            right = reciprocal_sum**3 - q3 * reciprocal_sum * reciprocal_square_sum + q2 * reciprocal_cube_sum
            assert left == middle, (data["name"], a)
            assert middle == right, (data["name"], a)
            assert left == right, (data["name"], a)
print("RESULT: PASS — transitivity links the third coefficient ratio to the cubic reciprocal-sum identity")
