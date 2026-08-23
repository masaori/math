# 対象ラベル: theorem_fisher_zero_positive_rational_shifted_product_coefficient_ratio
# 式ペア: Z_G(q) / eta(Omega_G(d)) in QQ_{>0}; its iota image at q=1 gives the shifted product
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-positive-rational-shifted-product-coefficient-ratio/_prelude.sage")
for data in examples:
    for q in positive_rational_evaluation_points:
        rational_evaluation = QQ(data["polynomial"](QQbar(q)))
        rational_ratio = rational_evaluation / data["leading_coefficient"]
        assert rational_ratio in QQ, (data["name"], q)
        assert rational_ratio > 0, (data["name"], q)
    rational_at_one = QQ(data["polynomial"](QQbar(1))) / data["leading_coefficient"]
    embedded_at_one = QQbar(rational_at_one)
    shifted_product_at_one = prod((QQbar(1) - alpha for alpha in data["roots"]), QQbar(1))
    assert embedded_at_one == shifted_product_at_one, data["name"]
print("RESULT: PASS — the ratio is positive rational and q=1 recovers the existing shifted-product identity")
