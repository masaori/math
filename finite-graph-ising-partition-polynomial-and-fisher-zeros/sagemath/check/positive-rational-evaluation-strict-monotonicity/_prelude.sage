# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_strict_monotonicity
# 帰属: 有限集合、NN、QQ、QQ[x] だけを用いる

from itertools import product


def partition_data(vertex_count, edges):
    polynomial_ring = PolynomialRing(QQ, "x")
    x = polynomial_ring.gen()
    configurations = tuple(product((0, 1), repeat=vertex_count))
    broken_counts = tuple(
        NN(sum(1 for source, target in edges if configuration[source] != configuration[target]))
        for configuration in configurations
    )
    multiplicities = tuple(
        NN(sum(1 for broken_count in broken_counts if broken_count == degree))
        for degree in range(len(edges) + 1)
    )
    polynomial = sum(
        (QQ(multiplicities[degree]) * x**degree for degree in range(len(edges) + 1)),
        polynomial_ring.zero(),
    )
    first_source, first_target = edges[0]
    witness_configuration = tuple(1 if vertex == first_source else 0 for vertex in range(vertex_count))
    witness_degree = NN(
        sum(
            1
            for source, target in edges
            if witness_configuration[source] != witness_configuration[target]
        )
    )
    return multiplicities, polynomial, first_source, first_target, witness_degree


examples = (
    (2, ((0, 1),)),
    (2, ((0, 1), (0, 1))),
    (2, ((0, 1), (0, 1), (0, 1))),
    (3, ((0, 1), (1, 2))),
    (3, ((0, 1), (1, 2), (2, 0))),
    (4, ((0, 1), (1, 2), (2, 3), (3, 0))),
    (4, ((0, 1), (0, 2), (0, 3), (1, 2), (2, 3))),
)


strictly_ordered_positive_rational_pairs = (
    (QQ(1) / 3, QQ(1) / 2),
    (QQ(1) / 2, QQ(1)),
    (QQ(1), QQ(3) / 2),
    (QQ(3) / 2, QQ(2)),
    (QQ(1) / 3, QQ(2)),
)
