# 対象ラベル: theorem_full_cut_coefficient_symmetry
# 帰属: 有限集合、NN、ZZ[x] だけを用いる

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-coefficient-symmetry/_prelude.sage")

for name, vertex_count, edges, chosen_vertices in examples:
    polynomial_ring, configurations, polynomial = partition_polynomial(
        vertex_count, edges
    )
    edge_count = ZZ(len(edges))

    assert all(
        (source in chosen_vertices) != (target in chosen_vertices)
        for source, target in edges
    )

    for configuration in configurations:
        flipped = flip_on_vertex_subset(configuration, chosen_vertices)
        assert flip_on_vertex_subset(flipped, chosen_vertices) == configuration
        assert broken_edge_count(flipped, edges) == (
            edge_count - broken_edge_count(configuration, edges)
        )

    for degree in range(len(edges) + 1):
        assert polynomial[degree] == polynomial[len(edges) - degree]

_, _, triangle_polynomial = partition_polynomial(
    3, ((0, 1), (1, 2), (2, 0))
)
assert triangle_polynomial[0] != triangle_polynomial[3]

print(
    "RESULT: PASS — every full-cut example has complementary broken-edge "
    "counts and symmetric exact ZZ[x] coefficients; the triangle confirms "
    "that the full-cut hypothesis is not vacuous"
)
