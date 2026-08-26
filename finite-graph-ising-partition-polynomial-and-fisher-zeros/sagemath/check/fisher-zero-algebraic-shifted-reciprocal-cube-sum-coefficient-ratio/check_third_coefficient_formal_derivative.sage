# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: D^3 Pbar_G(x) = sum_m iota(eta(Omega_G(m))) prod_{r=0}^2 iota(eta(m-r)) x^(m-3)
# 帰属: 有限集合、NN、QQ、QQbar、QQbar[x] だけを用いる
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    coefficient_third_derivative = sum(
        (
            QQbar(QQ(data["multiplicities"][exponent]))
            * prod(
                (
                    QQbar(QQ(NN(exponent - offset)))
                    for offset in range(3)
                ),
                QQbar.one(),
            )
            * data["x"] ** (exponent - 3)
            for exponent in range(3, data["edge_count"] + 1)
        ),
        data["polynomial_ring"].zero(),
    )
    assert data["polynomial"].derivative(3) == coefficient_third_derivative, data["name"]

print("RESULT: PASS — the third coefficient-side formal derivative is exact")
