# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: Pbar_G(a) = iota(eta(Omega_G(d))) prod_j (a-alpha_j)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    roots = data["roots"]
    for a in algebraic_evaluation_points:
        polynomial_value = data["polynomial"](a)
        evaluated_factorization = data["leading_coefficient"] * prod(
            (a - alpha for alpha in roots),
            QQbar(1),
        )
        assert polynomial_value == evaluated_factorization, (data["name"], a)
print("RESULT: PASS — evaluating the linear factorization gives the displayed root-difference product")
