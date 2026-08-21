# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_monotonicity
# 式ペア: Z_G(q_1) <= Z_G(q_2)
# 帰属: QQ、QQ[x]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/positive-rational-evaluation-monotonicity/_prelude.sage")

for example in examples:
    _, polynomial = partition_data(*example)
    for q_1, q_2 in ordered_positive_rational_pairs:
        assert QQ(polynomial(q_1)) <= QQ(polynomial(q_2))

print("RESULT: PASS — every tested Ising partition polynomial is monotone on ordered positive rationals")
