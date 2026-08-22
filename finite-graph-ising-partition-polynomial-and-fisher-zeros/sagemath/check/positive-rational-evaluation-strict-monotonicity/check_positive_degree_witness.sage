# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_strict_monotonicity
# 式ペア: e_* in B_G(sigma_*), m_* = b_G(sigma_*) >= 1, Omega_G(m_*) >= 1
# 帰属: 有限集合、NN

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/positive-rational-evaluation-strict-monotonicity/_prelude.sage")

for example in examples:
    multiplicities, _, first_source, first_target, witness_degree = partition_data(*example)
    assert first_source != first_target
    assert witness_degree >= 1
    assert witness_degree <= len(example[1])
    assert multiplicities[witness_degree] >= 1

print("RESULT: PASS — every tested nonempty graph has the constructed positive-degree configuration and coefficient")
