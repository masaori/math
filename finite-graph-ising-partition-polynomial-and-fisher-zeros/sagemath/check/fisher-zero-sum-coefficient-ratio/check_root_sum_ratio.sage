# 対象ラベル: theorem_fisher_zero_sum_coefficient_ratio
# 式ペア: sum_j alpha_j = -Omega_G(d-1)/Omega_G(d)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial = data["polynomial"]
    degree = data["degree"]
    root_sum = sum(data["roots"], QQbar(0))
    coefficient_ratio = -QQ(polynomial[degree - 1]) / QQ(polynomial[degree])
    assert polynomial[degree] > 0, data["name"]
    assert root_sum == QQbar(coefficient_ratio), data["name"]

print("RESULT: PASS — every multiplicity-counted Fisher-zero sum equals the negative high-degree coefficient ratio")
