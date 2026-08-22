# 対象ラベル: theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio
# 式ペア: e_k(alpha^(-1)) = (-1)^k Omega_G(k) / Omega_G(0)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-elementary-symmetric-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial = data["polynomial"]
    roots = data["roots"]
    assert polynomial[0] > 0, data["name"]
    assert all(alpha != 0 for alpha in roots), data["name"]
    reciprocal_roots = tuple(alpha ** (-1) for alpha in roots)
    for cardinality in range(data["degree"] + 1):
        reciprocal_symmetric_sum = selected_products(reciprocal_roots, cardinality)
        coefficient_ratio = (-1) ** cardinality * QQ(polynomial[cardinality]) / QQ(polynomial[0])
        assert reciprocal_symmetric_sum == QQbar(coefficient_ratio), (data["name"], cardinality)

print("RESULT: PASS — every reciprocal elementary symmetric Fisher-zero sum equals its signed low-degree coefficient ratio")
