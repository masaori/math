# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: C_G(a) / Pbar_G(a) = T_{G,3}(a)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        polynomial_value = data["polynomial"](a)
        if polynomial_value != 0:
            assert coefficient_sum(data, a, 3) / polynomial_value == ordered_distinct_triple_sum(data, a), (data["name"], a)
print("RESULT: PASS — substituting the third coefficient sum into the derivative ratio gives the ordered distinct-triple reciprocal sum")
