# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: a nonzero product of root differences has only nonzero factors
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    roots = data["roots"]
    for a in algebraic_evaluation_points:
        root_product = prod((a - alpha for alpha in roots), QQbar(1))
        if root_product != 0:
            for index, alpha in enumerate(roots):
                assert a - alpha != 0, (data["name"], a, index)
print("RESULT: PASS — every nonzero root-difference product has only nonzero factors")
