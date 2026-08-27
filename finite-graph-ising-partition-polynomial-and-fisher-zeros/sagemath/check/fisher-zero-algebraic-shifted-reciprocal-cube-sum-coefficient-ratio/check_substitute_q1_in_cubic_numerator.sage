# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: -A_G(a)^3 = -q_1 A_G(a)^3
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        A = coefficient_sum(data, a, 1)
        assert -(A**3) == -q1 * A**3, (data["name"], a)
print("RESULT: PASS — substituting q_1=1 preserves the negative cubic term")
