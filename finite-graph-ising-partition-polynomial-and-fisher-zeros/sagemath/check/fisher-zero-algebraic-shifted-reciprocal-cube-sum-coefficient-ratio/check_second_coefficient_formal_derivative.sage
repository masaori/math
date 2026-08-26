# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: D^2 Pbar_G(x) = sum_m iota(eta(Omega_G(m))) iota(eta(m)) iota(eta(m-1)) x^(m-2)
# 帰属: 有限集合、NN、QQ、QQbar、QQbar[x] だけを用いる
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    coefficient_second_derivative = sum(
        (
            QQbar(QQ(data["multiplicities"][exponent]))
            * QQbar(QQ(NN(exponent)))
            * QQbar(QQ(NN(exponent - 1)))
            * data["x"] ** (exponent - 2)
            for exponent in range(2, data["edge_count"] + 1)
        ),
        data["polynomial_ring"].zero(),
    )
    assert data["polynomial"].derivative(2) == coefficient_second_derivative, data["name"]

print("RESULT: PASS — the second coefficient-side formal derivative is exact")
