# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: Pbar_G(a)(R_G(a)^2-S_{G,2}(a)) = D^2 Pbar_G(a)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            reciprocal_sum = sum(((a - alpha)**(-1) for alpha in data["roots"]), QQbar(0))
            reciprocal_square_sum = sum(((a - alpha)**(-2) for alpha in data["roots"]), QQbar(0))
            left = data["polynomial"](a) * (reciprocal_sum**2 - reciprocal_square_sum)
            right = data["polynomial"].derivative().derivative()(a)
            assert left == right, (data["name"], a)
print("RESULT: PASS — the shifted reciprocal pair sum equals the second logarithmic-derivative numerator")
