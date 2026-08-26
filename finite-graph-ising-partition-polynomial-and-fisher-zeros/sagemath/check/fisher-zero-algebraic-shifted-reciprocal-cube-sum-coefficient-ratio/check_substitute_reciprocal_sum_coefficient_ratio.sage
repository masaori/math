# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: q_2 S_{G,3} = C/P - R_G^3 + q_3 R_G S_{G,2}
#       -> q_2 S_{G,3} = C/P - (A/P)^3 + q_3 (A/P) S_{G,2}
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        P = data["polynomial"](a)
        if P != 0:
            A = coefficient_sum(data, a, 1)
            C = coefficient_sum(data, a, 3)
            reciprocal_sum = reciprocal_power_sum(data, a, 1)
            reciprocal_square_sum = reciprocal_power_sum(data, a, 2)
            before_substitution = C / P - reciprocal_sum**3 + q3 * reciprocal_sum * reciprocal_square_sum
            after_substitution = C / P - (A / P) ** 3 + q3 * (A / P) * reciprocal_square_sum
            assert reciprocal_sum == A / P, (data["name"], a)
            assert before_substitution == after_substitution, (data["name"], a)
print("RESULT: PASS — the reciprocal-sum coefficient formula substitutes into the cubic identity exactly")
