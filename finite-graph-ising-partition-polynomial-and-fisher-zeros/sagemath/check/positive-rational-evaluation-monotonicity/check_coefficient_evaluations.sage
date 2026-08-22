# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_monotonicity
# 式ペア: Z_G(q_i) = sum_m Omega_G(m) q_i^m, i in {1,2}
# 帰属: NN、QQ、QQ[x]

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/positive-rational-evaluation-monotonicity/_prelude.sage")

for example in examples:
    multiplicities, polynomial = partition_data(*example)
    for q_1, q_2 in ordered_positive_rational_pairs:
        for q in (q_1, q_2):
            coefficient_sum = sum(
                (QQ(multiplicities[degree]) * q**degree for degree in range(len(multiplicities))),
                QQ.zero(),
            )
            assert QQ(polynomial(q)) == coefficient_sum

print("RESULT: PASS — both exact rational evaluations equal their multiplicity coefficient sums")
