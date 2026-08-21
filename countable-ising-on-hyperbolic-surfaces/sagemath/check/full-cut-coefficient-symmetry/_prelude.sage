# 対象ラベル: theorem_full_cut_coefficient_symmetry
# 帰属: 有限集合、NN、ZZ[x] だけを用いる

from itertools import product


def broken_edge_count(configuration, edges):
    return ZZ(
        sum(
            1
            for source, target in edges
            if configuration[source] != configuration[target]
        )
    )


def partition_polynomial(vertex_count, edges):
    polynomial_ring = PolynomialRing(ZZ, "x")
    x = polynomial_ring.gen()
    configurations = tuple(product((0, 1), repeat=vertex_count))
    polynomial = sum(
        (
            x ** broken_edge_count(configuration, edges)
            for configuration in configurations
        ),
        polynomial_ring.zero(),
    )
    return polynomial_ring, configurations, polynomial


def flip_on_vertex_subset(configuration, chosen_vertices):
    return tuple(
        1 - spin if vertex in chosen_vertices else spin
        for vertex, spin in enumerate(configuration)
    )


examples = (
    ("one edge", 2, ((0, 1),), frozenset((0,))),
    ("three-vertex path", 3, ((0, 1), (1, 2)), frozenset((0, 2))),
    (
        "four-vertex cycle",
        4,
        ((0, 1), (1, 2), (2, 3), (3, 0)),
        frozenset((0, 2)),
    ),
    ("two parallel edges", 2, ((0, 1), (0, 1)), frozenset((0,))),
)
