# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: D^3 Pbar_G(a) = sum_m iota(eta(m(m-1)(m-2) Omega_G(m))) a^(m-3)
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
        assert data["polynomial"].derivative(3)(a) == displayed_coefficient_sum, (data["name"], a)
print("RESULT: PASS — evaluating the third formal derivative gives the displayed finite coefficient sum")
