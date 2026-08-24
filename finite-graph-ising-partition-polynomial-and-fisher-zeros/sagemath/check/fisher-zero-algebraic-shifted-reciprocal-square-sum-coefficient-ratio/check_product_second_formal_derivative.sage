# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: D^2 Pbar_G(x) = Omega_G(d) sum_k sum_{l != k} prod_{j != k,l}(x-alpha_j)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    ordered_excluded_pair_sum = sum(
        (
            prod(
                (
                    data["x"] - alpha
                    for index, alpha in enumerate(data["roots"])
                    if index != first and index != second
                ),
                data["polynomial_ring"].one(),
            )
            for first in range(data["degree"])
            for second in range(data["degree"])
            if first != second
        ),
        data["polynomial_ring"].zero(),
    )
    assert data["polynomial"].derivative().derivative() == data["leading_coefficient"] * ordered_excluded_pair_sum, data["name"]
print("RESULT: PASS — the finite product rule gives the sum with each ordered pair of distinct roots omitted")
