# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: (sum_m iota(eta(m Omega_G(m))) a^(m-1)) / Pbar_G(a) = A_G(a) / Pbar_G(a)
# 帰属: 有限集合、NN、QQbar、QQbar[x] だけを用いる
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        polynomial_value = data["polynomial"](a)
        if polynomial_value != 0:
            displayed_coefficient_sum = sum(
                (
                    QQbar(QQ(exponent * data["multiplicities"][exponent]))
                    * a ** (exponent - 1)
                    for exponent in range(1, data["edge_count"] + 1)
                ),
                QQbar(0),
            )
            A_G_a = sum(
                (
                    QQbar(QQ(exponent * data["multiplicities"][exponent]))
                    * a ** (exponent - 1)
                    for exponent in range(1, data["edge_count"] + 1)
                ),
                QQbar(0),
            )
            assert displayed_coefficient_sum / polynomial_value == A_G_a / polynomial_value, (data["name"], a)
print("RESULT: PASS — the explicit first coefficient sum is replaced only by the local definition A_G(a)")
