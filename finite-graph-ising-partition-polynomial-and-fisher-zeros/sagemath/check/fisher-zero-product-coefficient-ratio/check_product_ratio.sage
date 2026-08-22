# 対象ラベル: theorem_fisher_zero_product_coefficient_ratio
# 式ペア: product_j alpha_j = (-1)^d Omega_G(0) / Omega_G(d)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-product-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial = data["polynomial"]
    degree = data["degree"]
    root_product = QQbar(prod(data["roots"]))
    coefficient_ratio = QQbar(polynomial[0] / polynomial[degree])
    assert polynomial[degree] != 0, data["name"]
    assert coefficient_ratio == (-1)^degree * root_product, data["name"]
    assert root_product == (-1)^degree * coefficient_ratio, data["name"]

print("RESULT: PASS — every multiplicity-counted Fisher zero product equals the signed endpoint-coefficient ratio")
