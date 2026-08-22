# 対象ラベル: theorem_fisher_zeros_nonzero
# 式ペア: product_j alpha_j = (-1)^d Omega_G(0)/Omega_G(d) != 0

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zeros-nonzero/_prelude.sage")

for data in examples:
    polynomial = data["polynomial"]
    degree = data["degree"]
    root_product = QQbar(prod(data["roots"]))
    signed_ratio = (-1)**degree * QQbar(polynomial[0] / polynomial[degree])
    assert root_product == signed_ratio, data["name"]
    assert signed_ratio != 0, data["name"]
    assert root_product != 0, data["name"]

print("RESULT: PASS — every multiplicity-counted Fisher-zero product is nonzero")
