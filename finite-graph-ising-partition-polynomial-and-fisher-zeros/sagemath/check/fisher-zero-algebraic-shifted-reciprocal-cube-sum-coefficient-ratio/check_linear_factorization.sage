# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: Pbar_G(x) = iota(eta(Omega_G(d))) prod_j (x-alpha_j)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    linear_factorization = data["leading_coefficient"] * prod(
        (data["x"] - alpha for alpha in data["roots"]),
        data["polynomial_ring"].one(),
    )
    assert data["polynomial"] == linear_factorization, data["name"]
print("RESULT: PASS — the multiplicity-counted linear factorization equals the partition polynomial")
