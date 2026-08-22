# 対象ラベル: theorem_partition_polynomial_reciprocity_characterizes_full_cut
# 式: full cut implies sum_n Omega_G(|E|-n)x^n = sum_n Omega_G(n)x^n = Z_G(x)
# 帰属: NN、ZZ[x]

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/polynomial-reciprocity-full-cut-characterization/_prelude.sage")

for name, vertex_count, edges in examples:
    x, edge_count, multiplicities, polynomial = partition_data(vertex_count, edges)
    if has_full_cut(vertex_count, edges):
        reversed_coefficients = sum(
            ZZ(multiplicities[edge_count - degree]) * x^degree
            for degree in range(edge_count + 1)
        )
        direct_coefficients = sum(
            ZZ(multiplicities[degree]) * x^degree
            for degree in range(edge_count + 1)
        )
        assert reversed_coefficients == direct_coefficients, name
        assert direct_coefficients == polynomial, name

print("RESULT: PASS — every full-cut example has symmetric coefficients and recovers Z_G(x)")
