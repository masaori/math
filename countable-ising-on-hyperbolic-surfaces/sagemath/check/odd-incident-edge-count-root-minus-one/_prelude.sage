# 対象ラベル: theorem_odd_incident_edge_count_root_minus_one
# 帰属: 有限集合、NN、ZZ、ZZ[x] だけを用いる

from itertools import product


def build_example(vertex_count, edges, vertex):
    polynomial_ring = PolynomialRing(ZZ, "x")
    x = polynomial_ring.gen()
    configurations = tuple(product((0, 1), repeat=vertex_count))
    incident_edges = frozenset(
        edge_index
        for edge_index, (source, target) in enumerate(edges)
        if source == vertex or target == vertex
    )

    def flip(configuration):
        return tuple(1 - spin if index == vertex else spin for index, spin in enumerate(configuration))

    def broken_edges(configuration):
        return frozenset(
            edge_index
            for edge_index, (source, target) in enumerate(edges)
            if configuration[source] != configuration[target]
        )

    polynomial = sum((x ** len(broken_edges(configuration)) for configuration in configurations), polynomial_ring.zero())
    return configurations, incident_edges, flip, broken_edges, polynomial


examples = (
    (2, ((0, 1),), 0),
    (3, ((0, 1), (1, 2)), 0),
    (2, ((0, 1), (0, 1), (0, 1)), 0),
    (4, ((0, 1), (0, 2), (0, 3), (1, 2), (2, 3)), 0),
)
