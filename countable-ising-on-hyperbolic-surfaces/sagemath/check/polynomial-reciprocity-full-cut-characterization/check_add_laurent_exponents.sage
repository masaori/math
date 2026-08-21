# 対象ラベル: theorem_partition_polynomial_reciprocity_characterizes_full_cut
# 式: sum_m Omega_G(m)x^|E|x^(-m) = sum_m Omega_G(m)x^(|E|-m)
# 帰属: ZZ[x,x^(-1)]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/polynomial-reciprocity-full-cut-characterization/_prelude.sage")

for name, vertex_count, edges in examples:
    x, edge_count, multiplicities, _ = partition_data(vertex_count, edges)
    left = sum(
        ZZ(multiplicities[degree]) * x^edge_count * x^(-degree)
        for degree in range(edge_count + 1)
    )
    right = sum(
        ZZ(multiplicities[degree]) * x^(edge_count - degree)
        for degree in range(edge_count + 1)
    )
    assert left == right, name

print("RESULT: PASS — Laurent exponent addition agrees in every example")
