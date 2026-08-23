# 対象ラベル: theorem_fisher_zero_algebraic_shifted_product_evaluation_quotient
# 式ペア: Pbar_G(b) != 0 implies product_j (b-alpha_j) != 0 in QQbar
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-product-evaluation-quotient/_prelude.sage")
for data in examples:
    for b in algebraic_evaluation_points:
        evaluation = data["polynomial"](b)
        if evaluation != 0:
            embedded_leading_multiplicity = QQbar(QQ(data["leading_multiplicity"]))
            denominator_product = prod((b - alpha for alpha in data["roots"]), QQbar(1))
            coefficient_ratio = evaluation / embedded_leading_multiplicity
            assert embedded_leading_multiplicity == data["leading_coefficient"], (data["name"], b)
            assert denominator_product == coefficient_ratio, (data["name"], b)
            assert denominator_product != 0, (data["name"], b)
print("RESULT: PASS — every nonzero denominator evaluation gives a nonzero shifted-root product")
