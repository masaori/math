# 対象ラベル: theorem_even_linear_factor_characterizes_odd_incident_edge_count
# 帰属: 有限集合、NN、ZZ、ZZ[x] だけを用いる

from itertools import product


def build_example(vertex_count, edges):
    polynomial_ring = PolynomialRing(ZZ, "x")
    x = polynomial_ring.gen()
    configurations = tuple(product((0, 1), repeat=vertex_count))
    partition_polynomial = sum(
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
    incident_edge_counts = tuple(
        ZZ(sum(1 for source, target in edges if source == vertex or target == vertex))
        for vertex in range(vertex_count)
    )
    half_polynomial = polynomial_ring(
        [ZZ(coefficient) // 2 for coefficient in partition_polynomial.list()]
    )
    return x, partition_polynomial, half_polynomial, incident_edge_counts


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
