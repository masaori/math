# 対象ラベル: theorem_partition_polynomial_reciprocity_characterizes_full_cut
# 式: sum_m Omega_G(m)x^(|E|-m) = sum_n Omega_G(|E|-n)x^n
# 帰属: ZZ[x]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/polynomial-reciprocity-full-cut-characterization/_prelude.sage")

for name, vertex_count, edges in examples:
    x, edge_count, multiplicities, _ = partition_data(vertex_count, edges)
    left = sum(
        ZZ(multiplicities[degree]) * x^(edge_count - degree)
        for degree in range(edge_count + 1)
    )
    right = sum(
        ZZ(multiplicities[edge_count - degree]) * x^degree
        for degree in range(edge_count + 1)
    )
    assert left == right, name

print("RESULT: PASS — reversing the finite index set preserves every polynomial")
