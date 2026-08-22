# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_at_most_configuration_count
# 式ペア: Z_G(q) <= Z_G(1) iff q <= 1
# 帰属: QQ、QQ[x]

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/positive-rational-evaluation-at-most-configuration-count/_prelude.sage")

for example in examples:
    _, polynomial, _, _, _ = partition_data(*example)
    value_at_one = QQ(polynomial(QQ(1)))
    for q in positive_rational_points:
        value = QQ(polynomial(q))
        assert (value <= value_at_one) == (q <= QQ(1))

print("RESULT: PASS — weak order against the tested value at one exactly reflects weak order against one")

