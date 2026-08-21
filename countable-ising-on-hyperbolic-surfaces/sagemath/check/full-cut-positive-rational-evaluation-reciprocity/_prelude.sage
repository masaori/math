# 対象ラベル: theorem_full_cut_positive_rational_evaluation_reciprocity
# 帰属: 有限集合、NN、QQ、QQ[x] だけを用いる

from itertools import product


def broken_edge_count(configuration, edges):
    return NN(
        sum(
            1
            for source, target in edges
            if configuration[source] != configuration[target]
        )
    )


def partition_data(vertex_count, edges):
    polynomial_ring = PolynomialRing(QQ, "x")
    x = polynomial_ring.gen()
    configurations = tuple(product((0, 1), repeat=vertex_count))
    edge_count = NN(len(edges))
    multiplicities = tuple(
        NN(
            sum(
                1
                for configuration in configurations
                if broken_edge_count(configuration, edges) == degree
            )
        )
        for degree in range(edge_count + 1)
    )
    polynomial = sum(
        QQ(multiplicities[degree]) * x^degree
        for degree in range(edge_count + 1)
    )
    return edge_count, multiplicities, polynomial


examples = (
    ("one vertex without edges", 1, (), frozenset()),
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

positive_rational_points = (QQ(1) / 3, QQ(1) / 2, QQ(1), QQ(3) / 2, QQ(2))
