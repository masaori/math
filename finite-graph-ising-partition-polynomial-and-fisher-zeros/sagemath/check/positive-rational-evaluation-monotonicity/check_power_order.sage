# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_monotonicity
# 式ペア: 0 < q_1 <= q_2 implies q_1^m <= q_2^m
# 帰属: NN、QQ

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/positive-rational-evaluation-monotonicity/_prelude.sage")

for edges_example in examples:
    edge_count = len(edges_example[1])
    for q_1, q_2 in ordered_positive_rational_pairs:
        assert QQ.zero() < q_1
        assert q_1 <= q_2
        for degree in range(edge_count + 1):
            assert q_1**NN(degree) <= q_2**NN(degree)

print("RESULT: PASS — every tested nonnegative power preserves the ordered positive rational pair")
