# 対象ラベル: theorem_full_cut_positive_rational_evaluation_reciprocity
# 式: sum Omega_G(n) q^(|E|-n) = sum Omega_G(n) q^|E| q^(-n)
# 帰属: NN、QQ

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-positive-rational-evaluation-reciprocity/_prelude.sage")

for name, vertex_count, edges, chosen_vertices in examples:
    edge_count, multiplicities, polynomial = partition_data(vertex_count, edges)
    for q in positive_rational_points:
        complementary_power_sum = sum(
            QQ(multiplicities[degree]) * q^(edge_count - degree)
            for degree in range(edge_count + 1)
        )
        split_power_sum = sum(
            QQ(multiplicities[degree]) * q^edge_count * q^(-degree)
            for degree in range(edge_count + 1)
        )
        assert complementary_power_sum == split_power_sum

print("RESULT: PASS — every exact rational power splits by the exponent law")
