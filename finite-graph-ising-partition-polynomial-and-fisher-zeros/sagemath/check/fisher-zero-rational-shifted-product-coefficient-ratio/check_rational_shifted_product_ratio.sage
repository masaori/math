# 対象ラベル: theorem_fisher_zero_rational_shifted_product_coefficient_ratio
# 式ペア: product_j (iota(q)-alpha_j) = iota(Z_G(q) / eta(Omega_G(d))) in QQbar
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-rational-shifted-product-coefficient-ratio/_prelude.sage")
for data in examples:
    for q in rational_evaluation_points:
        left = prod((QQbar(q) - alpha for alpha in data["roots"]), QQbar(1))
        rational_evaluation = QQ(data["polynomial"](QQbar(q)))
        rational_ratio = rational_evaluation / data["leading_coefficient"]
        embedded_ratio = QQbar(rational_ratio)
        assert left == embedded_ratio, (data["name"], q)
        assert rational_ratio in QQ, (data["name"], q)
print("RESULT: PASS — every shifted-root product equals the QQbar image of a rational evaluation ratio")
