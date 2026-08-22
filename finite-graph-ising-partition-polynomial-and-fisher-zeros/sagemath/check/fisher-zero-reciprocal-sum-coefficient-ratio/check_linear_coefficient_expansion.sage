# 対象ラベル: theorem_fisher_zero_reciprocal_sum_coefficient_ratio
# 式ペア: Omega_G(1) = Omega_G(d) sum_k product_(j != k) (-alpha_j)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-reciprocal-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial = data["polynomial"]
    degree = data["degree"]
    roots = data["roots"]
    expanded_linear_coefficient = polynomial[degree] * sum(
        prod(-roots[index] for index in range(degree) if index != omitted_index)
        for omitted_index in range(degree)
    )
    assert degree > 0, data["name"]
    assert polynomial[1] == expanded_linear_coefficient, data["name"]

print("RESULT: PASS — the linear coefficient equals the sum of all one-factor choices in the exact factorization")
