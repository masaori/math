# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_strict_monotonicity
# 式ペア: sum_m Omega_G(m) q_1^m < sum_m Omega_G(m) q_2^m
# 帰属: NN、QQ

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/positive-rational-evaluation-strict-monotonicity/_prelude.sage")

for example in examples:
    multiplicities, _, _, _, witness_degree = partition_data(*example)
    for q_1, q_2 in strictly_ordered_positive_rational_pairs:
        left_terms = tuple(QQ(value) * q_1**degree for degree, value in enumerate(multiplicities))
        right_terms = tuple(QQ(value) * q_2**degree for degree, value in enumerate(multiplicities))
        assert all(left <= right for left, right in zip(left_terms, right_terms))
        assert left_terms[witness_degree] < right_terms[witness_degree]
        assert sum(left_terms, QQ.zero()) < sum(right_terms, QQ.zero())

print("RESULT: PASS — one strict term and the remaining weak terms give a strict finite-sum inequality")
