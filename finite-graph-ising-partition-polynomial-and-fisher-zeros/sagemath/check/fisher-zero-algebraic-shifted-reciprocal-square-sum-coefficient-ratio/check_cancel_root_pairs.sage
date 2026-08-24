# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: prod_j(a-alpha_j) / ((a-alpha_k)(a-alpha_l)) = prod_{j != k,l}(a-alpha_j)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            total_product = prod((a - alpha for alpha in data["roots"]), QQbar(1))
            factorized_value = data["leading_coefficient"] * total_product
            assert data["polynomial"](a) == factorized_value, (data["name"], a)
            assert factorized_value != 0, (data["name"], a)
            assert total_product != 0, (data["name"], a)
            root_differences = [a - alpha for alpha in data["roots"]]
            assert all(difference != 0 for difference in root_differences), (data["name"], a)
            for first in range(data["degree"]):
                for second in range(first + 1, data["degree"]):
                    omitted_product = prod(
                        (
                            a - alpha
                            for index, alpha in enumerate(data["roots"])
                            if index != first and index != second
                        ),
                        QQbar(1),
                    )
                    denominator = (a - data["roots"][first]) * (a - data["roots"][second])
                    assert total_product / denominator == omitted_product, (data["name"], a, first, second)
print("RESULT: PASS — factorization evaluation, nonzero-product cancellation, and pair cancellation hold separately")
