# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_strictly_below_configuration_count
# 式ペア: Z_G(q) < Z_G(1) iff q < 1
# 帰属: QQ、QQ[x]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/positive-rational-evaluation-strictly-below-configuration-count/_prelude.sage")

for example in examples:
    _, polynomial, _, _, _ = partition_data(*example)
    value_at_one = QQ(polynomial(QQ(1)))
    for q in positive_rational_points:
        assert (QQ(polynomial(q)) < value_at_one) == (q < QQ(1))

print("RESULT: PASS — strict order below the tested value at one exactly reflects strict order below one")
