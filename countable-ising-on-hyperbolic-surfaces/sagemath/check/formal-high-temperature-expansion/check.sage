from itertools import product, combinations

R = PolynomialRing(ZZ, names=("u", "v"))
u, v = R.gens()


def subsets(values):
    values = list(values)
    for size in range(len(values) + 1):
        for chosen in combinations(values, size):
            yield frozenset(chosen)


def is_even_subset(vertices, edges, chosen):
    for vertex in vertices:
        incidence = sum(1 for edge_index in chosen if vertex in edges[edge_index])
        if incidence % 2 != 0:
            return False
    return True


def verify_graph(vertices, edges):
    configurations = [dict(zip(vertices, values)) for values in product((-1, 1), repeat=len(vertices))]
    left = R.zero()
    for spin in configurations:
        term = R.one()
        for endpoint0, endpoint1 in edges:
            term *= u + v * spin[endpoint0] * spin[endpoint1]
        left += term

    right_core = R.zero()
    for chosen in subsets(range(len(edges))):
        if is_even_subset(vertices, edges, chosen):
            right_core += u ** (len(edges) - len(chosen)) * v ** len(chosen)
    right = (2 ** len(vertices)) * right_core
    assert left == right


verify_graph((0,), ())
verify_graph((0, 1), ((0, 1),))
verify_graph((0, 1, 2), ((0, 1), (1, 2), (2, 0)))
verify_graph((0, 1, 2, 3), ((0, 1), (1, 2), (2, 3), (3, 0), (0, 2)))
print("PASS: formal high-temperature expansion over ZZ[u,v]")

