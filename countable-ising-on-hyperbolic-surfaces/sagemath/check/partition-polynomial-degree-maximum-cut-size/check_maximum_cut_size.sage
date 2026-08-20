# 対象ラベル: theorem_partition_polynomial_degree_maximum_cut_size
# 帰属: 有限集合、NN、ZZ[x] だけを用いる

from itertools import product


def partition_degree_and_maximum_cut(vertex_count, edges):
    polynomial_ring = PolynomialRing(ZZ, "x")
    x = polynomial_ring.gen()
    configurations = list(product((0, 1), repeat=vertex_count))
    broken_counts = [
        ZZ(sum(1 for source, target in edges if configuration[source] != configuration[target]))
        for configuration in configurations
    ]
    polynomial = sum((x**broken_count for broken_count in broken_counts), polynomial_ring.zero())

    vertex_subsets = list(product((False, True), repeat=vertex_count))
    cut_sizes = [
        ZZ(sum(1 for source, target in edges if subset[source] != subset[target]))
        for subset in vertex_subsets
    ]

    assert set(broken_counts) == set(cut_sizes)
    assert ZZ(polynomial.degree()) == max(broken_counts)
    assert ZZ(polynomial.degree()) == max(cut_sizes)


examples = (
    (3, ((0, 1), (1, 2), (2, 0))),
    (4, ((0, 1), (1, 2), (2, 3), (3, 0))),
    (4, ((0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3))),
    (2, ((0, 1), (0, 1))),
)

for example in examples:
    partition_degree_and_maximum_cut(*example)

print("RESULT: PASS — every exact ZZ[x] degree equals the maximum cut size")
