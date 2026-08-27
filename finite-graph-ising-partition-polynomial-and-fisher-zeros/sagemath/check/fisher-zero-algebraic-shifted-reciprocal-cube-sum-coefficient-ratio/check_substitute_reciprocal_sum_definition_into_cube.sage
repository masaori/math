# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: R_G(a)^3 = (sum_k 1/(a-alpha_k))^3
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            reciprocal_sum = reciprocal_power_sum(data, a, 1)
            explicit_sum = sum(((a - alpha) ** (-1) for alpha in data["roots"]), QQbar(0))
            assert reciprocal_sum**3 == explicit_sum**3, (data["name"], a)
print("RESULT: PASS — substituting the reciprocal-sum definition preserves the cube")
