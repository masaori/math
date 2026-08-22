# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_strict_monotonicity
# 式ペア: Z_G(q_1) < Z_G(q_2)
# 帰属: QQ、QQ[x]

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/positive-rational-evaluation-strict-monotonicity/_prelude.sage")

for example in examples:
    _, polynomial, _, _, _ = partition_data(*example)
    for q_1, q_2 in strictly_ordered_positive_rational_pairs:
        assert QQ(polynomial(q_1)) < QQ(polynomial(q_2))

print("RESULT: PASS — every tested nonempty graph partition polynomial is strictly increasing on tested positive rationals")
