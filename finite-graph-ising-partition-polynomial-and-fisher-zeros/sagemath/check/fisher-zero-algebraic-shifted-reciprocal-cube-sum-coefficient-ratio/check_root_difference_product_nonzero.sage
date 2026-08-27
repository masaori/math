# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: a nonzero leading-coefficient product gives a nonzero root-difference product
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    roots = data["roots"]
    leading_coefficient = data["leading_coefficient"]
    assert leading_coefficient != 0, data["name"]
    for a in algebraic_evaluation_points:
        root_product = prod((a - alpha for alpha in roots), QQbar(1))
        evaluated_factorization = leading_coefficient * root_product
        if evaluated_factorization != 0:
            assert root_product != 0, (data["name"], a)
print("RESULT: PASS — every nonzero leading-coefficient product has a nonzero root-difference product")
