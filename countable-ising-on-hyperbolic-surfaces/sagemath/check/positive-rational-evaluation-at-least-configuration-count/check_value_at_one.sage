# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_at_least_configuration_count
# 式ペア: Z_G(1) = 2^|V|
# 帰属: NN、QQ、QQ[x]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/positive-rational-evaluation-at-least-configuration-count/_prelude.sage")

for vertex_count, edges in examples:
    _, polynomial, _, _, _ = partition_data(vertex_count, edges)
    assert QQ(polynomial(QQ(1))) == QQ(2**vertex_count)

print("RESULT: PASS — every tested partition polynomial equals the configuration count at one")
