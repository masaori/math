# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: sum_{j=1}^d 1/(a-alpha_j)^3 = S_{G,3}(a)
# 帰属: a, alpha_j, S_{G,3}(a) は QQbar に属する
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            displayed_sum = sum(
                ((a - alpha) ** (-3) for alpha in data["roots"]),
                QQbar(0),
            )
            local_definition = reciprocal_power_sum(data, a, 3)
            assert displayed_sum == local_definition, (data["name"], a)
print("RESULT: PASS — the displayed reciprocal cube sum equals its local definition")
