# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_at_least_configuration_count
# 式ペア: 2^|V| <= Z_G(q) iff 1 <= q
# 帰属: NN、QQ、QQ[x]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/positive-rational-evaluation-at-least-configuration-count/_prelude.sage")

for vertex_count, edges in examples:
    _, polynomial, _, _, _ = partition_data(vertex_count, edges)
    configuration_count = QQ(2**vertex_count)
    for q in positive_rational_points:
        value = QQ(polynomial(q))
        assert (configuration_count <= value) == (QQ(1) <= q)

print("RESULT: PASS — the tested evaluation is at least the configuration count exactly when the positive rational point is at least one")
