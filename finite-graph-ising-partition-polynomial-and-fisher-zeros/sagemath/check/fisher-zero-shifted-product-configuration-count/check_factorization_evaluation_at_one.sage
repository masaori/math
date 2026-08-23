# 対象ラベル: theorem_fisher_zero_shifted_product_configuration_count
# 式ペア: Pbar_G(1) = Omega_G(d) product_j (1-alpha_j)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-shifted-product-configuration-count/_prelude.sage")
for data in examples:
    left = data["polynomial"](QQbar(1))
    right = QQbar(data["leading_coefficient"]) * prod(
        (QQbar(1) - alpha for alpha in data["roots"]),
        QQbar(1),
    )
    assert left == right, data["name"]
print("RESULT: PASS — evaluating the linear factorization at one gives the shifted-root product")
