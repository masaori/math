# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio
# 式ペア: R_G(a) = (sum_m m Omega_G(m) a^(m-1)) / Pbar_G(a)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            reciprocal_sum = sum(((a - alpha)**(-1) for alpha in data["roots"]), QQbar(0))
            coefficient_sum = sum(
                (
                    QQbar(exponent * data["multiplicities"][exponent]) * a ** (exponent - 1)
                    for exponent in range(1, data["edge_count"] + 1)
                ),
                QQbar(0),
            )
            assert reciprocal_sum == coefficient_sum / data["polynomial"](a), (data["name"], a)
print("RESULT: PASS — the shifted reciprocal sum equals the finite coefficient sum divided by the evaluation")
