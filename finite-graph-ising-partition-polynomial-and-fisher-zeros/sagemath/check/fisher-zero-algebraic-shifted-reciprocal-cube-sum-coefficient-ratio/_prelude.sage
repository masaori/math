# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 帰属: 有限集合、NN、ZZ、QQ、QQbar、QQbar[x] だけを用いる

from itertools import product


def partition_data(name, vertex_count, edges):
    polynomial_ring = PolynomialRing(QQbar, "x")
    x = polynomial_ring.gen()
    configurations = tuple(product((0, 1), repeat=vertex_count))
    broken_counts = tuple(
        ZZ(sum(1 for source, target in edges if configuration[source] != configuration[target]))
        for configuration in configurations
    )
    edge_count = NN(len(edges))
    degree = NN(max(broken_counts))
    multiplicities = tuple(
        NN(sum(1 for broken_count in broken_counts if broken_count == exponent))
        for exponent in range(edge_count + 1)
    )
    polynomial = sum(
        (QQbar(QQ(multiplicities[exponent])) * x**exponent for exponent in range(edge_count + 1)),
        polynomial_ring.zero(),
    )
    roots = tuple(
        alpha
        for alpha, multiplicity in polynomial.roots(ring=QQbar)
        for _index in range(ZZ(multiplicity))
    )
    assert len(roots) == degree, name
    return {
        "name": name,
        "edge_count": edge_count,
        "degree": degree,
        "multiplicities": multiplicities,
        "leading_coefficient": QQbar(QQ(multiplicities[degree])),
        "polynomial": polynomial,
        "polynomial_ring": polynomial_ring,
        "roots": roots,
        "x": x,
    }


def coefficient_sum(data, a, derivative_order):
    return sum(
        (
            QQbar(QQ(prod((exponent - offset for offset in range(derivative_order)), ZZ(1)) * data["multiplicities"][exponent]))
            * a ** (exponent - derivative_order)
            for exponent in range(derivative_order, data["edge_count"] + 1)
        ),
        QQbar(0),
    )


def reciprocal_power_sum(data, a, power):
    return sum(((a - alpha) ** (-power) for alpha in data["roots"]), QQbar(0))


def ordered_distinct_pair_sum(data, a):
    roots = data["roots"]
    return sum(
        (
            (a - roots[first]) ** (-2) * (a - roots[second]) ** (-1)
            for first in range(data["degree"])
            for second in range(data["degree"])
            if first != second
        ),
        QQbar(0),
    )


def ordered_distinct_triple_sum(data, a):
    roots = data["roots"]
    return sum(
        (
            ((a - roots[first]) * (a - roots[second]) * (a - roots[third])) ** (-1)
            for first in range(data["degree"])
            for second in range(data["degree"])
            for third in range(data["degree"])
            if first != second and first != third and second != third
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

parameter_ring = PolynomialRing(QQ, "t")
t = parameter_ring.gen()
algebraic_evaluation_points = tuple(
    alpha
    for polynomial in (t**2 - 2, t**2 + 1, t**3 - 2)
    for alpha, multiplicity in polynomial.roots(ring=QQbar)
    for _index in range(ZZ(multiplicity))
)

q1 = QQbar(QQ(NN(1)))
q2 = QQbar(QQ(NN(2)))
q3 = QQbar(QQ(NN(3)))
