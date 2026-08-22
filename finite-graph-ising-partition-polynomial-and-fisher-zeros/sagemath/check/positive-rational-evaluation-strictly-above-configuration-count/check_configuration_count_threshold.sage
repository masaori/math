# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_strictly_above_configuration_count
# 式ペア: 2^|V| < Z_G(q) iff 1 < q
# 帰属: NN、QQ、QQ[x]

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/positive-rational-evaluation-strictly-above-configuration-count/_prelude.sage")

for vertex_count, edges in examples:
    _, polynomial, _, _, _ = partition_data(vertex_count, edges)
    configuration_count = QQ(2**vertex_count)
    for q in positive_rational_points:
        assert (configuration_count < QQ(polynomial(q))) == (QQ(1) < q)

print("RESULT: PASS — the tested evaluation lies above the configuration count exactly above the positive rational point one")
