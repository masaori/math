# 対象ラベル: theorem_partition_polynomial_reciprocity_characterizes_full_cut
# 式: x^|E| Z_G(x^(-1)) = x^|E| sum_m Omega_G(m) x^(-m)
# 帰属: ZZ[x,x^(-1)]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/polynomial-reciprocity-full-cut-characterization/_prelude.sage")

for name, vertex_count, edges in examples:
    x, edge_count, multiplicities, polynomial = partition_data(vertex_count, edges)
    left = x^edge_count * polynomial(x^(-1))
    right = x^edge_count * sum(
        ZZ(multiplicities[degree]) * x^(-degree)
        for degree in range(edge_count + 1)
    )
    assert left == right, name

print("RESULT: PASS — reciprocal substitution equals the multiplicity expansion in every example")
