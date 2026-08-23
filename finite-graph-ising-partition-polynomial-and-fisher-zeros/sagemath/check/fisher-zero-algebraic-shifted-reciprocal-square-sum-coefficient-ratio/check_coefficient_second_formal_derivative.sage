# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: D^2 Pbar_G(x) = sum_m m(m-1) Omega_G(m) x^(m-2)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    coefficient_second_derivative = sum(
        (
            QQbar(exponent * (exponent - 1) * data["multiplicities"][exponent])
            * data["x"] ** (exponent - 2)
            for exponent in range(2, data["edge_count"] + 1)
        ),
        data["polynomial_ring"].zero(),
    )
    assert data["polynomial"].derivative().derivative() == coefficient_second_derivative, data["name"]
print("RESULT: PASS — two termwise formal derivatives give the embedded finite coefficient sum")
