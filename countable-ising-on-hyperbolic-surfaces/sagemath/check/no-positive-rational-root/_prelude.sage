# 対象ラベル: theorem_no_positive_rational_root
# 帰属: 有限集合、NN、QQ、QQ[x] だけを用いる

from itertools import product


def partition_data(vertex_count, edges):
    polynomial_ring = PolynomialRing(QQ, "x")
    x = polynomial_ring.gen()
    configurations = tuple(product((0, 1), repeat=vertex_count))
    broken_counts = tuple(
        sum(
            1
            for source, target in edges
            if configuration[source] != configuration[target]
        )
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
    return x, configurations, broken_counts, multiplicities, polynomial


examples = (
    (1, ()),
    (2, ((0, 1),)),
    (2, ((0, 1), (0, 1))),
    (2, ((0, 1), (0, 1), (0, 1))),
    (3, ((0, 1), (1, 2))),
    (3, ((0, 1), (1, 2), (2, 0))),
    (4, ((0, 1), (1, 2), (2, 3), (3, 0))),
    (4, ((0, 1), (0, 2), (0, 3), (1, 2), (2, 3))),
)

positive_rationals = (QQ(1) / 3, QQ(1) / 2, QQ(1), QQ(3) / 2, QQ(2))
