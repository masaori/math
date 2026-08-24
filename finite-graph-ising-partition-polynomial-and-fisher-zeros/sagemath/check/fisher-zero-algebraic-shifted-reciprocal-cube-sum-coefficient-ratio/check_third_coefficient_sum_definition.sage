# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: D^3 Pbar_G(a) = C_G(a)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        assert data["polynomial"].derivative(3)(a) == coefficient_sum(data, a, 3), (data["name"], a)
print("RESULT: PASS — evaluating the third formal derivative gives the defined third coefficient sum")
