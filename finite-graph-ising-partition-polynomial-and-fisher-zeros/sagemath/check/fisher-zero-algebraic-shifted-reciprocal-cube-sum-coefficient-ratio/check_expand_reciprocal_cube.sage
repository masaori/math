# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: R_G(a)^3 = sum_{k,l,h} ((a-alpha_k)(a-alpha_l)(a-alpha_h))^(-1)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            roots = data["roots"]
            left = reciprocal_power_sum(data, a, 1) ** 3
            right = sum(
                (
                    ((a - roots[first]) * (a - roots[second]) * (a - roots[third])) ** (-1)
                    for first in range(data["degree"])
                    for second in range(data["degree"])
                    for third in range(data["degree"])
                ),
                QQbar(0),
            )
            assert left == right, (data["name"], a)
print("RESULT: PASS — the reciprocal cube expands into the ordered finite triple sum")
