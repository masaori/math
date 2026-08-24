# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: D Pbar_G(x) = sum_m iota(eta(Omega_G(m))) iota(eta(m)) x^(m-1)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    coefficient_first_derivative = sum(
        (
            QQbar(QQ(data["multiplicities"][exponent]))
            * QQbar(QQ(exponent))
            * data["x"] ** (exponent - 1)
            for exponent in range(1, data["edge_count"] + 1)
        ),
        data["polynomial_ring"].zero(),
    )
    assert data["polynomial"].derivative() == coefficient_first_derivative, data["name"]
print("RESULT: PASS — one termwise formal derivative gives the embedded finite coefficient sum")
