# 対象ラベル: theorem_full_cut_fisher_zero_reciprocal_multiplicity
# 帰属: 有限集合、NN、ZZ、QQbar、QQbar[x] だけを用いる

from itertools import combinations, product


R = PolynomialRing(QQbar, "x")
x = R.gen()
K = R.fraction_field()
x_fraction = K(x)


def broken_edge_count(configuration, edges):
    return NN(
        sum(
            1
            for source, target in edges
            if configuration[source] != configuration[target]
        )
    )


def partition_polynomial(vertex_count, edges):
    configurations = tuple(product((0, 1), repeat=vertex_count))
    return R(
        sum(
            x^broken_edge_count(configuration, edges)
            for configuration in configurations
        )
    )


def has_full_cut(vertex_count, edges):
    vertices = tuple(range(vertex_count))
    for size in range(vertex_count + 1):
        for chosen in combinations(vertices, size):
            selected = frozenset(chosen)
            if all((source in selected) != (target in selected) for source, target in edges):
                return True
    return False


def exact_multiplicity_and_cofactor(polynomial, alpha):
    factor = x - alpha
    multiplicity = NN(0)
    cofactor = polynomial
    while cofactor(alpha) == 0:
        quotient, remainder = cofactor.quo_rem(factor)
        assert remainder == 0
        cofactor = quotient
        multiplicity += 1
    return multiplicity, cofactor


examples = (
    ("one vertex without edges", 1, ()),
    ("one edge", 2, ((0, 1),)),
    ("three-vertex path", 3, ((0, 1), (1, 2))),
    ("four-vertex cycle", 4, ((0, 1), (1, 2), (2, 3), (3, 0))),
    ("two parallel edges", 2, ((0, 1), (0, 1))),
)


example_data = []
for name, vertex_count, edges in examples:
    assert has_full_cut(vertex_count, edges)
    polynomial = partition_polynomial(vertex_count, edges)
    roots = tuple(alpha for alpha, _multiplicity in polynomial.roots(ring=QQbar))
    sample_points = tuple(dict.fromkeys(roots + (QQbar(1), QQbar(2), QQbar(-2))))
    example_data.append(
        {
            "name": name,
            "edge_count": NN(len(edges)),
            "polynomial": polynomial,
            "sample_points": sample_points,
        }
    )
