# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_strictly_below_configuration_count
# 式ペア: Z_G(1) = 2^|V|
# 帰属: NN、QQ、QQ[x]

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/positive-rational-evaluation-strictly-below-configuration-count/_prelude.sage")

for vertex_count, edges in examples:
    _, polynomial, _, _, _ = partition_data(vertex_count, edges)
    assert QQ(polynomial(QQ(1))) == QQ(2**vertex_count)

print("RESULT: PASS — every tested partition polynomial equals the configuration count at one")
