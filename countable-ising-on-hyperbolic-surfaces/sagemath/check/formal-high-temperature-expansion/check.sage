from itertools import product, combinations

R = PolynomialRing(ZZ, names=("u", "v"))
u, v = R.gens()

SOURCE = "source"
TARGET = "target"
UP = "up"
DOWN = "down"
SPIN_INTEGER_REALIZATION = {UP: ZZ(1), DOWN: ZZ(-1)}


def subsets(values):
    values = list(values)
    for size in range(len(values) + 1):
        for chosen in combinations(values, size):
            yield frozenset(chosen)


def is_even_subset(vertices, edges, chosen):
    for vertex in vertices:
        incidence = sum(
            1
            for edge_name in chosen
            if vertex in {
                edges[edge_name][SOURCE],
                edges[edge_name][TARGET],
            }
        )
        if incidence % 2 != 0:
            return False
    return True


def verify_graph(vertices, edges):
    configurations = [dict(zip(vertices, values)) for values in product((UP, DOWN), repeat=len(vertices))]
    left = R.zero()
    for spin in configurations:
        term = R.one()
        for edge_name in edges:
            source_vertex = edges[edge_name][SOURCE]
            target_vertex = edges[edge_name][TARGET]
            source_spin = SPIN_INTEGER_REALIZATION[spin[source_vertex]]
            target_spin = SPIN_INTEGER_REALIZATION[spin[target_vertex]]
            term *= u + v * source_spin * target_spin
        left += term

    right_core = R.zero()
    for chosen in subsets(edges):
        if is_even_subset(vertices, edges, chosen):
            right_core += u ** (len(edges) - len(chosen)) * v ** len(chosen)
    right = (2 ** len(vertices)) * right_core
    assert left == right


verify_graph(("only",), {})
verify_graph(("left", "right"), {"bridge": {SOURCE: "left", TARGET: "right"}})
verify_graph(
    ("A", "B", "C"),
    {
        "AB": {SOURCE: "A", TARGET: "B"},
        "BC": {SOURCE: "B", TARGET: "C"},
        "CA": {SOURCE: "C", TARGET: "A"},
    },
)
verify_graph(
    ("A", "B", "C", "D"),
    {
        "AB": {SOURCE: "A", TARGET: "B"},
        "BC": {SOURCE: "B", TARGET: "C"},
        "CD": {SOURCE: "C", TARGET: "D"},
        "DA": {SOURCE: "D", TARGET: "A"},
        "AC": {SOURCE: "A", TARGET: "C"},
    },
)
print("PASS: formal high-temperature expansion over ZZ[u,v]")
