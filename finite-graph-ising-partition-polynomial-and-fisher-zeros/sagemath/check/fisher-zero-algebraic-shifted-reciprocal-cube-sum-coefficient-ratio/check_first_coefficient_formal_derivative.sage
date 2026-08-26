# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: D Pbar_G(x) = sum_m iota(eta(Omega_G(m))) iota(eta(m)) x^(m-1)
# 帰属: 有限集合、NN、QQ、QQbar、QQbar[x] だけを用いる
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    coefficient_first_derivative = sum(
        (
            QQbar(QQ(data["multiplicities"][exponent]))
            * QQbar(QQ(NN(exponent)))
            * data["x"] ** (exponent - 1)
            for exponent in range(1, data["edge_count"] + 1)
        ),
        data["polynomial_ring"].zero(),
    )
    assert data["polynomial"].derivative() == coefficient_first_derivative, data["name"]

print("RESULT: PASS — the first coefficient-side formal derivative is exact")
