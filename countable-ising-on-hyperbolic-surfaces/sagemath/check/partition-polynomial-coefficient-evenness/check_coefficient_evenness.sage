# 対象ラベル: theorem_partition_polynomial_coefficient_evenness
# 帰属: 有限集合、NN、ZZ[x] だけを用いる

from itertools import product


def check_coefficient_evenness(vertex_count, edges):
    polynomial_ring = PolynomialRing(ZZ, "x")
    x = polynomial_ring.gen()
    configurations = list(product((0, 1), repeat=vertex_count))

    def reverse(configuration):
        return tuple(1 - spin for spin in configuration)

    def broken_count(configuration):
        return NN(sum(1 for source, target in edges if configuration[source] != configuration[target]))

    assert all(reverse(reverse(configuration)) == configuration for configuration in configurations)
    assert all(reverse(configuration) != configuration for configuration in configurations)
    assert all(broken_count(reverse(configuration)) == broken_count(configuration) for configuration in configurations)

    polynomial = sum((x**broken_count(configuration) for configuration in configurations), polynomial_ring.zero())
    for degree in range(len(edges) + 1):
        fiber = [configuration for configuration in configurations if broken_count(configuration) == degree]
        assert all(reverse(configuration) in fiber for configuration in fiber)
        assert NN(len(fiber)) == NN(polynomial[degree])
        assert NN(len(fiber)) % 2 == 0


examples = (
    (1, ()),
    (2, ((0, 1),)),
    (3, ((0, 1), (1, 2), (2, 0))),
    (4, ((0, 1), (1, 2), (2, 3), (3, 0))),
    (2, ((0, 1), (0, 1))),
)

for example in examples:
    check_coefficient_evenness(*example)

print("RESULT: PASS — every exact ZZ[x] coefficient is even")
