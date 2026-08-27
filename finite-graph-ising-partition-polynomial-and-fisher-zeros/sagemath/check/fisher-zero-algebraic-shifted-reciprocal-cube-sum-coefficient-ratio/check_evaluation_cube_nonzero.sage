# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: Pbar_G(a) != 0 ならば Pbar_G(a)^3 != 0
# 帰属: Pbar_G(a) は QQbar に属する
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        P = data["polynomial"](a)
        if P != 0:
            assert P**3 != 0, (data["name"], a)
print("RESULT: PASS — the cube of every nonzero algebraic evaluation is nonzero")
