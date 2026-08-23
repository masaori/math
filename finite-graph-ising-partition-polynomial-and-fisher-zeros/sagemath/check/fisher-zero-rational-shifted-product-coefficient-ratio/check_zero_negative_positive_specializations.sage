# 対象ラベル: theorem_fisher_zero_rational_shifted_product_coefficient_ratio
# 式ペア: q=0 gives Omega_G(0)/Omega_G(d); negative and positive q retain the same identity
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-rational-shifted-product-coefficient-ratio/_prelude.sage")
for data in examples:
    at_zero = prod((-alpha for alpha in data["roots"]), QQbar(1))
    endpoint_ratio = QQbar(data["constant_coefficient"]) / QQbar(data["leading_coefficient"])
    assert at_zero == endpoint_ratio, data["name"]
    for q in (QQ(-1), QQ(1)):
        shifted_product = prod((QQbar(q) - alpha for alpha in data["roots"]), QQbar(1))
        evaluation_ratio = data["polynomial"](QQbar(q)) / QQbar(data["leading_coefficient"])
        assert shifted_product == evaluation_ratio, (data["name"], q)
print("RESULT: PASS — zero, negative, and positive rational specializations all satisfy the coefficient-ratio identity")
