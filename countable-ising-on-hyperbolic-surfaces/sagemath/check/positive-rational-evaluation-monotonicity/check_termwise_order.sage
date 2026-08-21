# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_monotonicity
# 式ペア: Omega_G(m) q_1^m <= Omega_G(m) q_2^m
# 帰属: NN、QQ

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/positive-rational-evaluation-monotonicity/_prelude.sage")

for example in examples:
    multiplicities, _ = partition_data(*example)
    for q_1, q_2 in ordered_positive_rational_pairs:
        for degree, multiplicity in enumerate(multiplicities):
            assert QQ(multiplicity) * q_1**degree <= QQ(multiplicity) * q_2**degree

print("RESULT: PASS — every multiplicity-weighted term preserves the rational order")
