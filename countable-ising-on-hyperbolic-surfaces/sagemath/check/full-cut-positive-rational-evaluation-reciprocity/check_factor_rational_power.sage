# 対象ラベル: theorem_full_cut_positive_rational_evaluation_reciprocity
# 式: sum Omega_G(n) q^|E| q^(-n) = q^|E| sum Omega_G(n) q^(-n)
# 帰属: NN、QQ

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-positive-rational-evaluation-reciprocity/_prelude.sage")

for name, vertex_count, edges, chosen_vertices in examples:
    edge_count, multiplicities, polynomial = partition_data(vertex_count, edges)
    for q in positive_rational_points:
        expanded_product_sum = sum(
            QQ(multiplicities[degree]) * q^edge_count * q^(-degree)
            for degree in range(edge_count + 1)
        )
        factored_sum = q^edge_count * sum(
            QQ(multiplicities[degree]) * q^(-degree)
            for degree in range(edge_count + 1)
        )
        assert expanded_product_sum == factored_sum

print("RESULT: PASS — finite distributivity factors the common rational power")
