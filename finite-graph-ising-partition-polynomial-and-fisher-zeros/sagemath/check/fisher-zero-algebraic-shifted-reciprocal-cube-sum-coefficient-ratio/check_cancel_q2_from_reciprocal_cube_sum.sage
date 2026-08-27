# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: q_2^{-1}(q_2S_{G,3}) = S_{G,3}
# 帰属: q_2, S_{G,3} は QQbar に属する
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        P = data["polynomial"](a)
        if P != 0:
            reciprocal_cube_sum = reciprocal_power_sum(data, a, 3)
            left = (QQbar(1) / q2) * (q2 * reciprocal_cube_sum)
            right = reciprocal_cube_sum
            assert left == right, (data["name"], a)
print("RESULT: PASS — the inverse of nonzero q_2 cancels q_2 in a separate QQbar equality")
