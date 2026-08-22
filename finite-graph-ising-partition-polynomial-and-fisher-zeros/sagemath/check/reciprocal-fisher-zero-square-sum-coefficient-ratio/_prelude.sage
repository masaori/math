# 対象ラベル: theorem_reciprocal_fisher_zero_square_sum_coefficient_ratio
# 帰属: 有限集合、NN、ZZ、QQ、QQbar、QQbar[x] だけを用いる

from itertools import combinations, product


def partition_data(name, vertex_count, edges):
    polynomial_ring = PolynomialRing(QQbar, "x")
    x = polynomial_ring.gen()
    configurations = tuple(product((0, 1), repeat=vertex_count))
    broken_counts = tuple(
        ZZ(sum(1 for source, target in edges if configuration[source] != configuration[target]))
        for configuration in configurations
    )
    degree = NN(max(broken_counts))
    multiplicities = tuple(
        NN(sum(1 for broken_count in broken_counts if broken_count == exponent))
        for exponent in range(len(edges) + 1)
    )
    polynomial = sum(
        (QQbar(multiplicities[exponent]) * x**exponent for exponent in range(len(edges) + 1)),
        polynomial_ring.zero(),
    )
    roots = tuple(
        alpha
        for alpha, multiplicity in polynomial.roots(ring=QQbar)
        for _index in range(ZZ(multiplicity))
    )
    assert degree >= 2, name
    assert all(alpha != 0 for alpha in roots), name
    return {
        "name": name,
        "degree": degree,
        "polynomial": polynomial,
        "roots": roots,
    }


def reciprocal_square_sum(roots):
    return sum((alpha**(-2) for alpha in roots), QQbar(0))


def reciprocal_pair_sum(roots):
    return sum(
        (roots[first]**(-1) * roots[second]**(-1) for first, second in combinations(range(len(roots)), 2)),
        QQbar(0),
    )


examples = (
    partition_data("triangle", 3, ((0, 1), (1, 2), (2, 0))),
    partition_data("four_cycle", 4, ((0, 1), (1, 2), (2, 3), (3, 0))),
    partition_data("triangle_and_isolated_vertex", 4, ((0, 1), (1, 2), (2, 0))),
    partition_data("five_edge_graph", 4, ((0, 1), (0, 2), (0, 3), (1, 2), (2, 3))),
)
