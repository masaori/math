# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: D^2 Pbar_G(x) = 2 Omega_G(d) sum_{k<l} prod_{j != k,l}(x-alpha_j)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    excluded_pair_sum = sum(
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
            for second in range(first + 1, data["degree"])
        ),
        data["polynomial_ring"].zero(),
    )
    assert data["polynomial"].derivative().derivative() == 2 * data["leading_coefficient"] * excluded_pair_sum, data["name"]
print("RESULT: PASS — the finite product rule gives twice the sum with each unordered root pair omitted")
