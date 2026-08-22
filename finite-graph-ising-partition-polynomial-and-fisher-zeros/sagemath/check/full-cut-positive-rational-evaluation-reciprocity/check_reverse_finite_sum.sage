# 対象ラベル: theorem_full_cut_positive_rational_evaluation_reciprocity
# 式: sum Omega_G(|E|-m) q^m = sum Omega_G(n) q^(|E|-n)
# 帰属: NN、QQ

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-positive-rational-evaluation-reciprocity/_prelude.sage")

for name, vertex_count, edges, chosen_vertices in examples:
    edge_count, multiplicities, polynomial = partition_data(vertex_count, edges)
    for q in positive_rational_points:
        sum_before_reindexing = sum(
            QQ(multiplicities[edge_count - degree]) * q^degree
            for degree in range(edge_count + 1)
        )
        sum_after_reindexing = sum(
            QQ(multiplicities[degree]) * q^(edge_count - degree)
            for degree in range(edge_count + 1)
        )
        assert sum_before_reindexing == sum_after_reindexing

print("RESULT: PASS — reversing the finite index gives the complementary exponent sum")
