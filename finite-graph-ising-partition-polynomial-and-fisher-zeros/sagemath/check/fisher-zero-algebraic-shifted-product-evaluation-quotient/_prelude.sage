# 対象ラベル: theorem_fisher_zero_algebraic_shifted_product_evaluation_quotient
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
    return {
        "name": name,
        "degree": degree,
        "leading_coefficient": QQbar(polynomial[degree]),
        "polynomial": polynomial,
        "roots": roots,
    }


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
