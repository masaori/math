# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: a nonzero polynomial evaluation gives a nonzero evaluated leading-coefficient product
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    roots = data["roots"]
    for a in algebraic_evaluation_points:
        polynomial_value = data["polynomial"](a)
        evaluated_factorization = data["leading_coefficient"] * prod(
            (a - alpha for alpha in roots),
            QQbar(1),
        )
        if polynomial_value != 0:
            assert polynomial_value == evaluated_factorization, (data["name"], a)
            assert evaluated_factorization != 0, (data["name"], a)
print("RESULT: PASS — every nonzero evaluation has a nonzero evaluated leading-coefficient product")
