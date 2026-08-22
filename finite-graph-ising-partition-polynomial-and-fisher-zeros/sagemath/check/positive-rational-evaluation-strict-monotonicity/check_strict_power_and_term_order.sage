# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_strict_monotonicity
# 式ペア: q_1^m_* < q_2^m_* and Omega_G(m_*) q_1^m_* < Omega_G(m_*) q_2^m_*
# 帰属: NN、QQ

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/positive-rational-evaluation-strict-monotonicity/_prelude.sage")

for example in examples:
    multiplicities, _, _, _, witness_degree = partition_data(*example)
    for q_1, q_2 in strictly_ordered_positive_rational_pairs:
        assert q_1**witness_degree < q_2**witness_degree
        assert (
            QQ(multiplicities[witness_degree]) * q_1**witness_degree
            < QQ(multiplicities[witness_degree]) * q_2**witness_degree
        )

print("RESULT: PASS — every tested witness gives a strictly ordered positive-degree term")
