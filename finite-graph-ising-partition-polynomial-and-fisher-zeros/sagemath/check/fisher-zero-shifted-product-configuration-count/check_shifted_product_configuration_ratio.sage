# 対象ラベル: theorem_fisher_zero_shifted_product_configuration_count
# 式ペア: product_j (1-alpha_j) = 2^|V| / Omega_G(d)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-shifted-product-configuration-count/_prelude.sage")
for data in examples:
    left = prod((QQbar(1) - alpha for alpha in data["roots"]), QQbar(1))
    right = QQ(2 ** data["vertex_count"]) / data["leading_coefficient"]
    assert left == right, data["name"]
    assert right > 0, data["name"]
print("RESULT: PASS — the shifted-root product is the positive rational configuration-count ratio")
