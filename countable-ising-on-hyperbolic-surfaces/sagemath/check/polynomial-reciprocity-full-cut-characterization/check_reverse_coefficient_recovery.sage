# 対象ラベル: theorem_partition_polynomial_reciprocity_characterizes_full_cut
# 式: Z_G(x) = x^|E| Z_G(x^(-1)) implies Omega_G(m) = Omega_G(|E|-m)
# 帰属: NN、ZZ[x,x^(-1)]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/polynomial-reciprocity-full-cut-characterization/_prelude.sage")

for name, vertex_count, edges in examples:
    x, edge_count, multiplicities, polynomial = partition_data(vertex_count, edges)
    reciprocal = x^edge_count * polynomial(x^(-1))
    if polynomial == reciprocal:
        for degree in range(edge_count + 1):
            coefficient_from_polynomial = polynomial[degree]
            coefficient_from_reciprocal = reciprocal[degree]
            assert coefficient_from_polynomial == ZZ(multiplicities[degree]), name
            assert coefficient_from_reciprocal == ZZ(multiplicities[edge_count - degree]), name
            assert multiplicities[degree] == multiplicities[edge_count - degree], name

print("RESULT: PASS — reciprocal equality recovers every coefficient symmetry in every applicable example")
