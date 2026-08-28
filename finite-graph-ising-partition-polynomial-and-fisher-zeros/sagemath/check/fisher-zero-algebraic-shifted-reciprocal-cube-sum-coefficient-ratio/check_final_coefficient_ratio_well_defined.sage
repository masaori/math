# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 本文主張: 最終係数比は非零分母をもつ QQbar の元として well-defined
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        P = data["polynomial"](a)
        if P != 0:
            A = coefficient_sum(data, a, 1)
            B = coefficient_sum(data, a, 2)
            C = coefficient_sum(data, a, 3)
            denominator = q2 * P**3
            assert denominator != 0, (data["name"], a)
            coefficient_ratio = (q2 * A**3 - q3 * P * A * B + P**2 * C) / denominator
            assert coefficient_ratio.parent() is QQbar, (data["name"], a)
print("RESULT: PASS — every final coefficient ratio is well-defined in QQbar")
