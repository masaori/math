# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: sum_k sum_{l != k} prod_{j != k,l}(x-alpha_j) = 2 sum_{k<l} prod_{j != k,l}(x-alpha_j)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
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
    unordered_pair_sum = sum(
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
    assert ordered_pair_sum == 2 * unordered_pair_sum, data["name"]
print("RESULT: PASS — every unordered omitted-root pair occurs in exactly two index orders")
