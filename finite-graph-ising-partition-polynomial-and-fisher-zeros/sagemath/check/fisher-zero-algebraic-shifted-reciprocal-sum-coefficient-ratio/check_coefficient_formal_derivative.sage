# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio
# 式ペア: D Pbar_G(x) = sum_{m=1}^{|E|} m Omega_G(m) x^(m-1)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    coefficient_derivative = sum(
        (
            QQbar(QQ(NN(exponent) * data["multiplicities"][exponent]))
            * data["x"] ** (exponent - 1)
            for exponent in range(1, data["edge_count"] + 1)
        ),
        data["polynomial_ring"].zero(),
    )
    assert data["polynomial"].derivative() == coefficient_derivative, data["name"]
print("RESULT: PASS — termwise formal differentiation gives the finite coefficient sum")
