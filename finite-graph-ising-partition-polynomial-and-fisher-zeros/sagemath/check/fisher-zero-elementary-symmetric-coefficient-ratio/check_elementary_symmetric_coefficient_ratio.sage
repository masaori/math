# 対象ラベル: theorem_fisher_zero_elementary_symmetric_coefficient_ratio
# 式ペア: sum_{|I|=k} prod_{j in I}alpha_j = (-1)^k Omega_G(d-k)/Omega_G(d)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-elementary-symmetric-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial = data["polynomial"]
    degree = data["degree"]
    assert polynomial[degree] > 0, data["name"]
    for cardinality in range(degree + 1):
        elementary_symmetric_sum = selected_products(data["roots"], cardinality)
        coefficient_ratio = (
            (-1) ** cardinality
            * QQ(polynomial[degree - cardinality])
            / QQ(polynomial[degree])
        )
        assert elementary_symmetric_sum == QQbar(coefficient_ratio), (data["name"], cardinality)

print("RESULT: PASS — every elementary symmetric Fisher-zero sum equals its signed high-degree coefficient ratio")
