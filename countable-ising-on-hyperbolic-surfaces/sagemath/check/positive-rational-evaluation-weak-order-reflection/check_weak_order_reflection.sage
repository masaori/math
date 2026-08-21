# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_weak_order_reflection
# 式ペア: Z_G(q_1) <= Z_G(q_2) if and only if q_1 <= q_2
# 帰属: QQ、QQ[x]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/positive-rational-evaluation-strict-monotonicity/_prelude.sage")

positive_rational_points = (
    QQ(1) / 3,
    QQ(1) / 2,
    QQ(1),
    QQ(3) / 2,
    QQ(2),
)

for example in examples:
    _, polynomial, _, _, _ = partition_data(*example)
    for q_1 in positive_rational_points:
        for q_2 in positive_rational_points:
            value_1 = QQ(polynomial(q_1))
            value_2 = QQ(polynomial(q_2))
            assert (value_1 <= value_2) == (q_1 <= q_2)

print("RESULT: PASS — weak order of tested positive rational evaluations exactly reflects weak order of evaluation points")
