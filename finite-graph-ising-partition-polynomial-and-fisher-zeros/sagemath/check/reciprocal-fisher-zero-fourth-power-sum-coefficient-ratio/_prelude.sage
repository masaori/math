# 対象ラベル: theorem_reciprocal_fisher_zero_fourth_power_sum_coefficient_ratio
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
    assert degree >= 4, name
    assert all(alpha != 0 for alpha in roots), name
    reciprocal_roots = tuple(alpha**(-1) for alpha in roots)
    return {"name": name, "degree": degree, "polynomial": polynomial, "roots": reciprocal_roots}


def elementary(roots, order):
    return sum(
        (prod((roots[index] for index in selected), QQbar(1)) for selected in combinations(range(len(roots)), order)),
        QQbar(0),
    )


def power_sum(roots, order):
    return sum((alpha**order for alpha in roots), QQbar(0))


def three_one_sum(roots):
    return sum(
        (roots[first]**3 * roots[second] + roots[first] * roots[second]**3
         for first, second in combinations(range(len(roots)), 2)),
        QQbar(0),
    )


def two_one_one_sum(roots):
    return sum(
        (roots[first] * roots[second] * roots[third]
         * (roots[first] + roots[second] + roots[third])
         for first, second, third in combinations(range(len(roots)), 3)),
        QQbar(0),
    )


examples = (
    partition_data("four_edge_path", 5, ((0, 1), (1, 2), (2, 3), (3, 4))),
    partition_data("four_edge_star", 5, ((0, 1), (0, 2), (0, 3), (0, 4))),
    partition_data("five_cycle", 5, ((0, 1), (1, 2), (2, 3), (3, 4), (4, 0))),
    partition_data("complete_graph_on_four_vertices", 4, ((0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3))),
)
