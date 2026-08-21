# 対象ラベル: theorem_partition_polynomial_reciprocity_characterizes_full_cut
# 式: x^|E| sum_m Omega_G(m)x^(-m) = sum_m x^|E| Omega_G(m)x^(-m)
# 帰属: ZZ[x,x^(-1)]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/polynomial-reciprocity-full-cut-characterization/_prelude.sage")

for name, vertex_count, edges in examples:
    x, edge_count, multiplicities, _ = partition_data(vertex_count, edges)
    left = x^edge_count * sum(
        ZZ(multiplicities[degree]) * x^(-degree)
        for degree in range(edge_count + 1)
    )
    right = sum(
        x^edge_count * ZZ(multiplicities[degree]) * x^(-degree)
        for degree in range(edge_count + 1)
    )
    assert left == right, name

print("RESULT: PASS — Laurent monomial distribution agrees in every example")
