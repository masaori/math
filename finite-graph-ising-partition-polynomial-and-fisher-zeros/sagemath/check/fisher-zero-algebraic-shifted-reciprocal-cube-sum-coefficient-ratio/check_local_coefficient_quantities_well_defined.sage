# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 本文主張: 三つの局所係数有限和 A_G(a), B_G(a), C_G(a) は QQbar に属する
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            local_coefficient_quantities = tuple(
                coefficient_sum(data, a, derivative_order)
                for derivative_order in (1, 2, 3)
            )
            assert all(value.parent() is QQbar for value in local_coefficient_quantities), (data["name"], a)
print("RESULT: PASS — A_G(a), B_G(a), and C_G(a) are well-defined in QQbar at each nonzero evaluation")
