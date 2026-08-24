# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: D^3 Pbar_G(a) / Pbar_G(a) = T_{G,3}(a)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        polynomial_value = data["polynomial"](a)
        if polynomial_value != 0:
            assert data["polynomial"].derivative(3)(a) / polynomial_value == ordered_distinct_triple_sum(data, a), (data["name"], a)
print("RESULT: PASS — division by the nonzero root product leaves the ordered distinct-triple reciprocal sum")
