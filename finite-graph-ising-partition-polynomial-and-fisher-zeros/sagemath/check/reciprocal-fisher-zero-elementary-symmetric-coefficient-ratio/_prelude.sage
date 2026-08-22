# 対象ラベル: theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio
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
    return {
        "name": name,
        "degree": degree,
        "multiplicities": multiplicities,
        "polynomial": polynomial,
        "roots": roots,
    }


def selected_products(values, cardinality):
    return sum(
        (
            prod(values[index] for index in selected_indices)
            for selected_indices in combinations(range(len(values)), cardinality)
        ),
        QQbar(0),
    )


examples = (
    partition_data("isolated_vertex", 1, ()),
    partition_data("one_edge", 2, ((0, 1),)),
    partition_data("triangle", 3, ((0, 1), (1, 2), (2, 0))),
    partition_data("triangle_and_isolated_vertex", 4, ((0, 1), (1, 2), (2, 0))),
    partition_data("five_edge_graph", 4, ((0, 1), (0, 2), (0, 3), (1, 2), (2, 3))),
)
