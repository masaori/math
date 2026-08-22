# 対象ラベル: theorem_fisher_zero_sum_coefficient_ratio
# 式ペア: Omega_G(d-1) = Omega_G(d) sum_k (-alpha_k)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial = data["polynomial"]
    degree = data["degree"]
    roots = data["roots"]
    expanded_high_degree_coefficient = polynomial[degree] * sum(-alpha for alpha in roots)
    assert degree > 0, data["name"]
    assert polynomial[degree - 1] == expanded_high_degree_coefficient, data["name"]

print("RESULT: PASS — the coefficient below the leading term equals the sum of all one-root choices")
