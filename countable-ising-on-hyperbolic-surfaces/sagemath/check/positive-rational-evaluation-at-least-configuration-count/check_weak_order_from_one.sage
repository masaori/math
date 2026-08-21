# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_at_least_configuration_count
# 式ペア: Z_G(1) <= Z_G(q) iff 1 <= q
# 帰属: QQ、QQ[x]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/positive-rational-evaluation-at-least-configuration-count/_prelude.sage")

for example in examples:
    _, polynomial, _, _, _ = partition_data(*example)
    value_at_one = QQ(polynomial(QQ(1)))
    for q in positive_rational_points:
        value = QQ(polynomial(q))
        assert (value_at_one <= value) == (QQ(1) <= q)

print("RESULT: PASS — weak order from the tested value at one exactly reflects weak order from one")
