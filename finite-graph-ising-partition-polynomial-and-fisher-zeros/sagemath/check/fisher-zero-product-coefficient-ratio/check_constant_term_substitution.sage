# 対象ラベル: theorem_fisher_zero_product_coefficient_ratio
# 式ペア: Omega_G(0) = Pbar_G(0) = Omega_G(d) product_j (0-alpha_j)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-product-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial = data["polynomial"]
    degree = data["degree"]
    roots = data["roots"]
    substituted_factorization = polynomial[degree] * prod(-alpha for alpha in roots)
    assert polynomial[0] == polynomial(0), data["name"]
    assert polynomial(0) == substituted_factorization, data["name"]

print("RESULT: PASS — zero substitution in every exact factorization gives the constant coefficient")
