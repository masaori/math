# 対象ラベル: theorem_no_linear_factor_x_minus_one
# 帰属: 有限集合、NN、ZZ、ZZ[x] だけを用いる

from itertools import product


def partition_polynomial(vertex_count, edges):
    polynomial_ring = PolynomialRing(ZZ, "x")
    x = polynomial_ring.gen()
    configurations = tuple(product((0, 1), repeat=vertex_count))
    polynomial = sum(
        (
            x ** sum(
                1
                for source, target in edges
                if configuration[source] != configuration[target]
            )
            for configuration in configurations
        ),
        polynomial_ring.zero(),
    )
    return x, configurations, polynomial


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
