# 対象ラベル: theorem_fisher_zero_positive_rational_shifted_product_coefficient_ratio
# 式ペア: product_j (q-alpha_j) = Z_G(q) / Omega_G(d)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-positive-rational-shifted-product-coefficient-ratio/_prelude.sage")
for data in examples:
    for q in positive_rational_evaluation_points:
        left = prod((QQbar(q) - alpha for alpha in data["roots"]), QQbar(1))
        right = data["polynomial"](QQbar(q)) / QQbar(data["leading_coefficient"])
        assert left == right, (data["name"], q)
print("RESULT: PASS — every shifted-root product equals the positive-rational evaluation ratio")
