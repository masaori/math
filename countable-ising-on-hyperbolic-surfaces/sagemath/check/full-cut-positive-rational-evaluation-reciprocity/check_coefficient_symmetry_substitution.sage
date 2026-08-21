# 対象ラベル: theorem_full_cut_positive_rational_evaluation_reciprocity
# 式: sum Omega_G(m) q^m = sum Omega_G(|E|-m) q^m
# 帰属: NN、QQ

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-positive-rational-evaluation-reciprocity/_prelude.sage")

for name, vertex_count, edges, chosen_vertices in examples:
    edge_count, multiplicities, polynomial = partition_data(vertex_count, edges)
    assert all(
        (source in chosen_vertices) != (target in chosen_vertices)
        for source, target in edges
    )
    assert all(
        multiplicities[degree] == multiplicities[edge_count - degree]
        for degree in range(edge_count + 1)
    )
    for q in positive_rational_points:
        original_sum = sum(
            QQ(multiplicities[degree]) * q^degree
            for degree in range(edge_count + 1)
        )
        symmetric_sum = sum(
            QQ(multiplicities[edge_count - degree]) * q^degree
            for degree in range(edge_count + 1)
        )
        assert original_sum == symmetric_sum

print("RESULT: PASS — coefficient symmetry preserves every tested exact rational sum")
