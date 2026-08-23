# 対象ラベル: theorem_fisher_zero_positive_rational_shifted_product_coefficient_ratio
# 式ペア: Pbar_G(iota(q)) = iota(eta(Omega_G(d))) product_j (iota(q)-alpha_j)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-positive-rational-shifted-product-coefficient-ratio/_prelude.sage")
for data in examples:
    for q in positive_rational_evaluation_points:
        left = data["polynomial"](QQbar(q))
        right = QQbar(data["leading_coefficient"]) * prod(
            (QQbar(q) - alpha for alpha in data["roots"]),
            QQbar(1),
        )
        assert left == right, (data["name"], q)
print("RESULT: PASS — evaluating the linear factorization at each positive rational point gives the shifted-root product")
