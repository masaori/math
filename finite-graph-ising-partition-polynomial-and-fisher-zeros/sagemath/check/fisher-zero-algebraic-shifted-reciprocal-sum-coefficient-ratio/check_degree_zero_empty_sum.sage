# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio
# 式ペア: degree zero gives empty root and coefficient sums, both equal to 0 in QQbar
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-sum-coefficient-ratio/_prelude.sage")
data = examples[0]
assert data["degree"] == 0
assert data["edge_count"] == 0
for a in algebraic_evaluation_points:
    reciprocal_sum = sum(((a - alpha)**(-1) for alpha in data["roots"]), QQbar(0))
    coefficient_sum = sum(
        (
            QQbar(exponent * data["multiplicities"][exponent]) * a ** (exponent - 1)
            for exponent in range(1, data["edge_count"] + 1)
        ),
        QQbar(0),
    )
    assert reciprocal_sum == QQbar(0), a
    assert coefficient_sum == QQbar(0), a
    assert reciprocal_sum == coefficient_sum / data["polynomial"](a), a
print("RESULT: PASS — the degree-zero theorem is the QQbar empty-sum identity")
