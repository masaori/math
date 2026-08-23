# 対象ラベル: theorem_fisher_zero_algebraic_shifted_product_evaluation_quotient
# 式ペア: degree zero gives the quotient of two empty products and the quotient of two equal evaluations
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-product-evaluation-quotient/_prelude.sage")
data = examples[0]
assert data["degree"] == 0
for a in algebraic_evaluation_points:
    for b in algebraic_evaluation_points:
        numerator_product = prod((a - alpha for alpha in data["roots"]), QQbar(1))
        denominator_product = prod((b - alpha for alpha in data["roots"]), QQbar(1))
        left = numerator_product / denominator_product
        right = data["polynomial"](a) / data["polynomial"](b)
        assert left == QQbar(1), (a, b)
        assert left == right, (a, b)
print("RESULT: PASS — degree-zero empty products give the same unit quotient as constant evaluations")
