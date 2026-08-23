# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: d=0 では零点和、一次係数和、二次係数和がすべて QQbar の零
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
data = examples[0]
assert data["degree"] == 0
assert sum(((QQbar(1) / (QQbar(2) - alpha) ** 2 for alpha in data["roots"])), QQbar(0)) == QQbar(0)
assert sum((QQbar(exponent) for exponent in range(1, data["edge_count"] + 1)), QQbar(0)) == QQbar(0)
assert sum((QQbar(exponent) for exponent in range(2, data["edge_count"] + 1)), QQbar(0)) == QQbar(0)
print("RESULT: PASS — the degree-zero theorem has three exact QQbar empty sums")
