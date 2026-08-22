# 対象ラベル: theorem_fisher_zero_reciprocal_sum_coefficient_ratio
# 式ペア: sum_j 1/alpha_j = -Omega_G(1)/Omega_G(0)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-reciprocal-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial = data["polynomial"]
    reciprocal_sum = sum(QQbar(1) / alpha for alpha in data["roots"])
    coefficient_ratio = -QQ(polynomial[1]) / QQ(polynomial[0])
    assert polynomial[0] > 0, data["name"]
    assert reciprocal_sum == QQbar(coefficient_ratio), data["name"]

print("RESULT: PASS — every multiplicity-counted reciprocal Fisher-zero sum equals the negative low-degree coefficient ratio")
