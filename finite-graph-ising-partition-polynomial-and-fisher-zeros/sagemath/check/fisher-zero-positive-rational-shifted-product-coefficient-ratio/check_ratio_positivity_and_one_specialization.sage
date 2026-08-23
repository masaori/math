# 対象ラベル: theorem_fisher_zero_positive_rational_shifted_product_coefficient_ratio
# 式ペア: Z_G(q) / Omega_G(d) in QQ_{>0}; q=1 gives 2^|V| / Omega_G(d)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-positive-rational-shifted-product-coefficient-ratio/_prelude.sage")
for data in examples:
    for q in positive_rational_evaluation_points:
        ratio = data["polynomial"](QQbar(q)) / QQbar(data["leading_coefficient"])
        assert ratio in QQ, (data["name"], q)
        assert QQ(ratio) > 0, (data["name"], q)
    at_one = data["polynomial"](QQbar(1)) / QQbar(data["leading_coefficient"])
    shifted_product_at_one = prod((QQbar(1) - alpha for alpha in data["roots"]), QQbar(1))
    assert at_one == shifted_product_at_one, data["name"]
print("RESULT: PASS — the ratio is positive rational and q=1 recovers the existing shifted-product identity")
