# 対象ラベル: def_fisher_zero_algebraic_shifted_reciprocal_sum
# 式ペア: degree zero gives the empty shifted reciprocal sum 0 in QQbar
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-sum/_prelude.sage")
data = examples[0]
assert data["degree"] == 0
for a in algebraic_evaluation_points:
    assert data["polynomial"](a) != 0
    reciprocal_sum = sum(((a - alpha)**(-1) for alpha in data["roots"]), QQbar(0))
    assert reciprocal_sum == QQbar(0), a
print("RESULT: PASS — the degree-zero shifted reciprocal sum is the QQbar zero")
