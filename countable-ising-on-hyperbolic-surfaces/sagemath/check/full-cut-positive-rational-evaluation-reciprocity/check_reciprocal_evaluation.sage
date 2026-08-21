# 対象ラベル: theorem_full_cut_positive_rational_evaluation_reciprocity
# 式: q^|E| sum Omega_G(n) q^(-n) = q^|E| Z_G(q^(-1))
# 帰属: NN、QQ、QQ[x]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-positive-rational-evaluation-reciprocity/_prelude.sage")

for name, vertex_count, edges, chosen_vertices in examples:
    edge_count, multiplicities, polynomial = partition_data(vertex_count, edges)
    for q in positive_rational_points:
        reciprocal_sum = q^edge_count * sum(
            QQ(multiplicities[degree]) * q^(-degree)
            for degree in range(edge_count + 1)
        )
        reciprocal_evaluation = q^edge_count * polynomial(q^(-1))
        assert reciprocal_sum == reciprocal_evaluation
        assert polynomial(q) == reciprocal_evaluation

print("RESULT: PASS — every full-cut example satisfies exact positive-rational reciprocity")
