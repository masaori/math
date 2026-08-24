# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: sum_m iota(eta(m(m-1) Omega_G(m))) a^(m-2) = B_G(a)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        displayed_coefficient_sum = sum(
            (
                QQbar(QQ(exponent * (exponent - 1) * data["multiplicities"][exponent]))
                * a ** (exponent - 2)
                for exponent in range(2, data["edge_count"] + 1)
            ),
            QQbar(0),
        )
        B_G_a = sum(
            (
                QQbar(QQ(exponent * (exponent - 1) * data["multiplicities"][exponent]))
                * a ** (exponent - 2)
                for exponent in range(2, data["edge_count"] + 1)
            ),
            QQbar(0),
        )
        assert displayed_coefficient_sum == B_G_a, (data["name"], a)
print("RESULT: PASS — the evaluated second coefficient sum equals the locally defined B_G(a)")
