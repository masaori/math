# 対象ラベル: theorem_fisher_zero_algebraic_shifted_product_coefficient_ratio
# 式ペア: a=iota(q) specializes the QQbar identity to the rational evaluation identity
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-product-coefficient-ratio/_prelude.sage")
for data in examples:
    for embedded_q in rational_evaluation_points:
        algebraic_product = prod((embedded_q - alpha for alpha in data["roots"]), QQbar(1))
        algebraic_ratio = data["polynomial"](embedded_q) / data["leading_coefficient"]
        rational_evaluation = QQ(data["polynomial"](embedded_q))
        rational_ratio = QQbar(rational_evaluation) / data["leading_coefficient"]
        assert algebraic_product == algebraic_ratio, (data["name"], embedded_q)
        assert algebraic_ratio == rational_ratio, (data["name"], embedded_q)
print("RESULT: PASS — rational points specialize the algebraic identity to the existing rational identity")
