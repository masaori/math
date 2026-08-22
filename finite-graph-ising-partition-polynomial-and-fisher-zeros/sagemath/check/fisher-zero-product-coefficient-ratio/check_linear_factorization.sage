# 対象ラベル: theorem_fisher_zero_product_coefficient_ratio
# 式ペア: Pbar_G(x) = Omega_G(d) product_j (x-alpha_j)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-product-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial = data["polynomial"]
    degree = data["degree"]
    roots = data["roots"]
    factorization = polynomial[degree] * prod(polynomial.parent().gen() - alpha for alpha in roots)
    assert len(roots) == degree, data["name"]
    assert polynomial == factorization, data["name"]

print("RESULT: PASS — every exact QQbar polynomial equals its leading coefficient times all linear factors")
