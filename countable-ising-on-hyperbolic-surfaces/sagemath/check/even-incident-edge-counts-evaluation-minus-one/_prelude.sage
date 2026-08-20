# 対象ラベル: theorem_even_incident_edge_counts_evaluation_minus_one
# 帰属: 有限集合、NN、ZZ、ZZ[x] だけを用いる

from itertools import product


def build_example(vertex_count, edges):
    polynomial_ring = PolynomialRing(ZZ, "x")
    x = polynomial_ring.gen()
    configurations = tuple(product((0, 1), repeat=vertex_count))

    def incident_edges(vertex):
        return frozenset(
            edge_index
            for edge_index, (source, target) in enumerate(edges)
            if source == vertex or target == vertex
        )

    def broken_edges(configuration):
        return frozenset(
            edge_index
            for edge_index, (source, target) in enumerate(edges)
            if configuration[source] != configuration[target]
        )

    polynomial = sum(
        (x ** len(broken_edges(configuration)) for configuration in configurations),
        polynomial_ring.zero(),
    )
    return configurations, incident_edges, broken_edges, polynomial


examples = (
    (1, ()),
    (3, ((0, 1), (1, 2), (2, 0))),
    (4, ((0, 1), (1, 2), (2, 3), (3, 0))),
    (2, ((0, 1), (0, 1))),
)
