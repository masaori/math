# 対象ラベル: theorem_full_cut_positive_rational_evaluation_reciprocity
# 式: Z_G(q) = sum_{m=0}^{|E|} Omega_G(m) q^m
# 帰属: NN、QQ、QQ[x]

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-positive-rational-evaluation-reciprocity/_prelude.sage")

for name, vertex_count, edges, chosen_vertices in examples:
    edge_count, multiplicities, polynomial = partition_data(vertex_count, edges)
    for q in positive_rational_points:
        evaluated_sum = sum(
            QQ(multiplicities[degree]) * q^degree
            for degree in range(edge_count + 1)
        )
        assert polynomial(q) == evaluated_sum

print("RESULT: PASS — polynomial evaluation equals the exact finite multiplicity sum")
