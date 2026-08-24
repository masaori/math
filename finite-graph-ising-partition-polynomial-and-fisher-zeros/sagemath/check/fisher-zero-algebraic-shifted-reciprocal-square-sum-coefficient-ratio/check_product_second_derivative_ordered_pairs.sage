# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: D(sum_k prod_{j != k}(x-alpha_j)) = sum_k sum_{l != k} prod_{j != k,l}(x-alpha_j)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    first_derivative_factor_sum = sum(
        (
            prod(
                (
                    data["x"] - alpha
                    for index, alpha in enumerate(data["roots"])
                    if index != first
                ),
                data["polynomial_ring"].one(),
            )
            for first in range(data["degree"])
        ),
        data["polynomial_ring"].zero(),
    )
    ordered_pair_sum = sum(
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
    assert first_derivative_factor_sum.derivative() == ordered_pair_sum, data["name"]
print("RESULT: PASS — differentiating the first product-rule sum gives the ordered distinct-pair sum")
