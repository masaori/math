# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio
# 式ペア: D Pbar_G(x) = Omega_G(d) sum_k prod_{j != k} (x-alpha_j)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    excluded_factor_sum = sum(
        (
            prod(
                (data["x"] - alpha for index, alpha in enumerate(data["roots"]) if index != omitted),
                data["polynomial_ring"].one(),
            )
            for omitted in range(data["degree"])
        ),
        data["polynomial_ring"].zero(),
    )
    assert data["polynomial"].derivative() == data["leading_coefficient"] * excluded_factor_sum, data["name"]
print("RESULT: PASS — the finite product rule gives the sum of products with one root factor omitted")
