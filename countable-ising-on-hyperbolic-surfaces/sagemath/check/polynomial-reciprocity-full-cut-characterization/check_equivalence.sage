# 対象ラベル: theorem_partition_polynomial_reciprocity_characterizes_full_cut
# 式: full cut exists iff Z_G(x) = x^|E| Z_G(x^(-1))
# 帰属: 有限集合、ZZ[x,x^(-1)]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/polynomial-reciprocity-full-cut-characterization/_prelude.sage")

for name, vertex_count, edges in examples:
    x, edge_count, _, polynomial = partition_data(vertex_count, edges)
    reciprocal = x^edge_count * polynomial(x^(-1))
    assert has_full_cut(vertex_count, edges) == (polynomial == reciprocal), name

print("RESULT: PASS — full-cut existence and Laurent-polynomial reciprocity agree in every example")
