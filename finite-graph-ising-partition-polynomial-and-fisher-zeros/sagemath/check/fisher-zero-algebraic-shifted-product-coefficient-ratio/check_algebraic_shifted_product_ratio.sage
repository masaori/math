# 対象ラベル: theorem_fisher_zero_algebraic_shifted_product_coefficient_ratio
# 式ペア: product_j (a-alpha_j) = Pbar_G(a) / Omega_G(d) in QQbar
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-product-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        left = prod((a - alpha for alpha in data["roots"]), QQbar(1))
        right = data["polynomial"](a) / data["leading_coefficient"]
        assert left == right, (data["name"], a)
        assert right in QQbar, (data["name"], a)
print("RESULT: PASS — every algebraic shifted-root product equals its QQbar evaluation ratio")
