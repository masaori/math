# 対象ラベル: theorem_partition_polynomial_reciprocity_characterizes_full_cut
# 帰属: 有限集合、NN、ZZ、ZZ[x,x^(-1)] だけを用いる

from itertools import combinations, product


def broken_edge_count(configuration, edges):
    return NN(
        sum(
            1
            for source, target in edges
            if configuration[source] != configuration[target]
        )
    )


def partition_data(vertex_count, edges):
    laurent_ring = LaurentPolynomialRing(ZZ, "x")
    x = laurent_ring.gen()
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
        ZZ(multiplicities[degree]) * x^degree
        for degree in range(edge_count + 1)
    )
    return x, edge_count, multiplicities, polynomial


def has_full_cut(vertex_count, edges):
    vertices = tuple(range(vertex_count))
    for size in range(vertex_count + 1):
        for chosen in combinations(vertices, size):
            selected = frozenset(chosen)
            if all((source in selected) != (target in selected) for source, target in edges):
                return True
    return False


examples = (
    ("one vertex without edges", 1, ()),
    ("one edge", 2, ((0, 1),)),
    ("three-vertex path", 3, ((0, 1), (1, 2))),
    ("triangle", 3, ((0, 1), (1, 2), (2, 0))),
    ("four-vertex cycle", 4, ((0, 1), (1, 2), (2, 3), (3, 0))),
    (
        "complete four-vertex graph",
        4,
        ((0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3)),
    ),
    ("two parallel edges", 2, ((0, 1), (0, 1))),
)
