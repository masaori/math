# 対象ラベル: theorem_fisher_zero_algebraic_shifted_product_coefficient_ratio
# 式ペア: Pbar_G(a) = Omega_G(d) product_j (a-alpha_j) in QQbar
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-product-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        left = data["polynomial"](a)
        right = data["leading_coefficient"] * prod(
            (a - alpha for alpha in data["roots"]),
            QQbar(1),
        )
        assert left == right, (data["name"], a)
print("RESULT: PASS — evaluating each linear factorization at algebraic points gives the shifted-root product")
