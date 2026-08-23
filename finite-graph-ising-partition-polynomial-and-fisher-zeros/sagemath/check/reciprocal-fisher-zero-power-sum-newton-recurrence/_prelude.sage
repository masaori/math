# 対象ラベル: theorem_reciprocal_fisher_zero_power_sum_newton_recurrence
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
    assert len(roots) == degree, name
    assert all(alpha != 0 for alpha in roots), name
    reciprocals = tuple(alpha**(-1) for alpha in roots)
    return {
        "name": name,
        "degree": degree,
        "polynomial": polynomial,
        "reciprocals": reciprocals,
    }


def elementary(values, order):
    return sum(
        (prod((values[index] for index in selected), QQbar(1)) for selected in combinations(range(len(values)), order)),
        QQbar(0),
    )


def power_sum(values, order):
    return sum((value**order for value in values), QQbar(0))


def indexed_sum(values, power_order, subset_order):
    return sum(
        (
            prod((values[index] for index in selected), QQbar(1))
            * sum((values[index]**(power_order - subset_order) for index in selected), QQbar(0))
            for selected in combinations(range(len(values)), subset_order)
        ),
        QQbar(0),
    )


examples = (
    partition_data("edgeless_graph", 2, ()),
    partition_data("one_edge", 2, ((0, 1),)),
    partition_data("four_edge_path", 5, ((0, 1), (1, 2), (2, 3), (3, 4))),
    partition_data("five_cycle", 5, ((0, 1), (1, 2), (2, 3), (3, 4), (4, 0))),
    partition_data("complete_graph_on_four_vertices", 4, ((0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3))),
)
