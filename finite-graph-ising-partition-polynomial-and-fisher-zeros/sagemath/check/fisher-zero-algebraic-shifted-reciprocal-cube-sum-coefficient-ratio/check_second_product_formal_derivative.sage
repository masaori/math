# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: D^2 Pbar_G(x) = iota(eta(Omega_G(d))) sum_k sum_{ell != k} prod_{j != k, j != ell} (x - alpha_j)
# 帰属: 有限集合、NN、QQ、QQbar、QQbar[x] だけを用いる
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    second_product_derivative = data["leading_coefficient"] * sum(
        (
            prod(
                (
                    data["x"] - data["roots"][root_index]
                    for root_index in range(data["degree"])
                    if root_index != first_omitted_index and root_index != second_omitted_index
                ),
                data["polynomial_ring"].one(),
            )
            for first_omitted_index in range(data["degree"])
            for second_omitted_index in range(data["degree"])
            if second_omitted_index != first_omitted_index
        ),
        data["polynomial_ring"].zero(),
    )
    assert data["polynomial"].derivative(2) == second_product_derivative, data["name"]

print("RESULT: PASS — the second product-side formal derivative is exact")
