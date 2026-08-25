# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: sum_m iota(eta(m(m-1)(m-2) Omega_G(m))) a^(m-3) = C_G(a)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        displayed_coefficient_sum = sum(
            (
                QQbar(QQ(exponent * (exponent - 1) * (exponent - 2) * data["multiplicities"][exponent]))
                * a ** (exponent - 3)
                for exponent in range(3, data["edge_count"] + 1)
            ),
            QQbar(0),
        )
        C_G_a = coefficient_sum(data, a, 3)
        assert displayed_coefficient_sum == C_G_a, (data["name"], a)
print("RESULT: PASS — the displayed third coefficient sum equals the locally defined C_G(a)")
