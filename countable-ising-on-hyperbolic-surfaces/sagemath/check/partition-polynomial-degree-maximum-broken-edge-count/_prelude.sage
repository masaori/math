# 対象ラベル: theorem_partition_polynomial_degree_maximum_broken_edge_count
# 帰属: 有限集合、NN、ZZ[x] だけを用いる

from itertools import product


def partition_data(vertex_count, edges):
    polynomial_ring = PolynomialRing(ZZ, "x")
    x = polynomial_ring.gen()
    configurations = list(product((0, 1), repeat=vertex_count))
    broken_counts = [
        ZZ(sum(1 for source, target in edges if configuration[source] != configuration[target]))
        for configuration in configurations
    ]
    multiplicities = {
        m: ZZ(sum(1 for broken_count in broken_counts if broken_count == m))
        for m in range(len(edges) + 1)
    }
    polynomial = sum(
        (multiplicities[m] * x**m for m in range(len(edges) + 1)),
        polynomial_ring.zero(),
    )
    return {
        "broken_counts": broken_counts,
        "multiplicities": multiplicities,
        "polynomial": polynomial,
    }


examples = {
    "triangle": partition_data(3, ((0, 1), (1, 2), (2, 0))),
    "four_cycle": partition_data(4, ((0, 1), (1, 2), (2, 3), (3, 0))),
    "two_parallel_edges": partition_data(2, ((0, 1), (0, 1))),
}
