# 対象ラベル: theorem_coefficient_symmetry_characterizes_full_cut
# 帰属: 有限集合、NN、ZZ[x] だけを用いる

from itertools import product


def all_vertex_subsets(vertex_count):
    vertices = tuple(range(vertex_count))
    return tuple(
        frozenset(vertices[index] for index in range(vertex_count) if mask & (1 << index))
        for mask in range(1 << vertex_count)
    )


def broken_edge_set(configuration, edges):
    return frozenset(
        index
        for index, (source, target) in enumerate(edges)
        if configuration[source] != configuration[target]
    )


def partition_data(vertex_count, edges):
    polynomial_ring = PolynomialRing(ZZ, "x")
    x = polynomial_ring.gen()
    configurations = tuple(product((0, 1), repeat=vertex_count))
    multiplicities = tuple(
        NN(
            sum(
                1
                for configuration in configurations
                if len(broken_edge_set(configuration, edges)) == degree
            )
        )
        for degree in range(len(edges) + 1)
    )
    polynomial = sum(
        ZZ(multiplicities[degree]) * x^degree
        for degree in range(len(edges) + 1)
    )
    return configurations, multiplicities, polynomial


def is_full_cut(vertex_subset, edges):
    return all(
        (source in vertex_subset) != (target in vertex_subset)
        for source, target in edges
    )


def has_full_cut(vertex_count, edges):
    return any(
        is_full_cut(vertex_subset, edges)
        for vertex_subset in all_vertex_subsets(vertex_count)
    )


def has_symmetric_coefficients(multiplicities):
    edge_count = len(multiplicities) - 1
    return all(
        multiplicities[degree] == multiplicities[edge_count - degree]
        for degree in range(edge_count + 1)
    )


examples = (
    ("one vertex without edges", 1, ()),
    ("one edge", 2, ((0, 1),)),
    ("three-vertex path", 3, ((0, 1), (1, 2))),
    ("triangle", 3, ((0, 1), (1, 2), (2, 0))),
    ("four-vertex cycle", 4, ((0, 1), (1, 2), (2, 3), (3, 0))),
    ("complete four-vertex graph", 4, ((0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3))),
    ("two parallel edges", 2, ((0, 1), (0, 1))),
)
