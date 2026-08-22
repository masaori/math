# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_equal_configuration_count
# 式ペア: Z_G(q) = 2^|V| iff q = 1
# 帰属: NN、QQ、QQ[x]

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/positive-rational-evaluation-equal-configuration-count/_prelude.sage")

for vertex_count, edges in examples:
    _, polynomial, _, _, _ = partition_data(vertex_count, edges)
    configuration_count = QQ(2**vertex_count)
    for q in positive_rational_points:
        assert (QQ(polynomial(q)) == configuration_count) == (q == QQ(1))

print("RESULT: PASS — the tested evaluation equals the configuration count exactly at the positive rational point one")
