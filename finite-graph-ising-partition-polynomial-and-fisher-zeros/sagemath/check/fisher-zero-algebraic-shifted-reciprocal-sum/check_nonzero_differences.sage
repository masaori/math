# 対象ラベル: def_fisher_zero_algebraic_shifted_reciprocal_sum
# 式ペア: Pbar_G(a) != 0 implies a-alpha_j != 0 for every multiplicity-indexed Fisher zero
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-sum/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        if data["polynomial"](a) != 0:
            differences = tuple(a - alpha for alpha in data["roots"])
            assert all(difference != 0 for difference in differences), (data["name"], a)
            reciprocal_sum = sum((difference**(-1) for difference in differences), QQbar(0))
            assert reciprocal_sum in QQbar, (data["name"], a)
print("RESULT: PASS — every nonzero algebraic evaluation gives defined QQbar reciprocals")
