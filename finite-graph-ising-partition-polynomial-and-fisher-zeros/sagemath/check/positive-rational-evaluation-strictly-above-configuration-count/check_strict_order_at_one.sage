# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_strictly_above_configuration_count
# 式ペア: Z_G(1) < Z_G(q) iff 1 < q
# 帰属: QQ、QQ[x]

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/positive-rational-evaluation-strictly-above-configuration-count/_prelude.sage")

for example in examples:
    _, polynomial, _, _, _ = partition_data(*example)
    value_at_one = QQ(polynomial(QQ(1)))
    for q in positive_rational_points:
        assert (value_at_one < QQ(polynomial(q))) == (QQ(1) < q)

print("RESULT: PASS — strict order above the tested value at one exactly reflects strict order above one")
