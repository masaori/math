# 対象ラベル: theorem_fisher_zero_algebraic_shifted_product_evaluation_quotient
# 式ペア: product_j(a-alpha_j)/product_j(b-alpha_j) = Pbar_G(a)/Pbar_G(b) in QQbar
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-product-evaluation-quotient/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        for b in algebraic_evaluation_points:
            denominator_evaluation = data["polynomial"](b)
            if denominator_evaluation != 0:
                numerator_product = prod((a - alpha for alpha in data["roots"]), QQbar(1))
                denominator_product = prod((b - alpha for alpha in data["roots"]), QQbar(1))
                left = numerator_product / denominator_product
                right = data["polynomial"](a) / denominator_evaluation
                assert left == right, (data["name"], a, b)
                assert right in QQbar, (data["name"], a, b)
print("RESULT: PASS — shifted-root product quotients equal algebraic evaluation quotients")
