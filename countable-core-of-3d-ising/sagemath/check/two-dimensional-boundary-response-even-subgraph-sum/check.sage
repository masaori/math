# 対象ラベル: claim_two_dimensional_boundary_response_even_subgraph_sum
# L'=1, L=2 の有限箱で、証明の各有限和を ZZ 上で同順に確認する。
from itertools import product, combinations


def subsets(values):
    for size in range(len(values) + 1):
        for chosen in combinations(values, size):
            yield frozenset(chosen)


vertices = list(product(range(2), repeat=2))
vertex_set = set(vertices)
edges = []
for start in vertices:
    for direction in range(2):
        end = list(start)
        end[direction] += 1
        end = tuple(end)
        if end in vertex_set:
            edges.append((start, end))

inner_vertices = {(0, 0)}
active_edges = [edge for edge in edges if edge[0] in inner_vertices or edge[1] in inner_vertices]
ring = PolynomialRing(ZZ, ["x%s" % index for index in range(len(active_edges))])
variables = ring.gens()
variable_of = dict(zip(active_edges, variables))

response = ring.zero()
for values in product([ZZ(-1), ZZ(1)], repeat=len(vertices)):
    configuration = dict(zip(vertices, values))
    monomial = ring.one()
    for edge in active_edges:
        if configuration[edge[0]] != configuration[edge[1]]:
            monomial *= variable_of[edge]
    response += monomial

even_sum = ring.zero()
for chosen in subsets(active_edges):
    degrees = {vertex: ZZ(0) for vertex in vertices}
    for edge in chosen:
        degrees[edge[0]] += 1
        degrees[edge[1]] += 1

    spin_sum = ZZ(0)
    for values in product([ZZ(-1), ZZ(1)], repeat=len(vertices)):
        configuration = dict(zip(vertices, values))
        spin_factor = ZZ(1)
        for edge in chosen:
            spin_factor *= configuration[edge[0]] * configuration[edge[1]]
        spin_sum += spin_factor

    is_even = all(degree % 2 == 0 for degree in degrees.values())
    assert spin_sum == (ZZ(2) ** len(vertices) if is_even else ZZ(0))
    if is_even:
        term = ring.one()
        for edge in active_edges:
            term *= (1 - variable_of[edge]) if edge in chosen else (1 + variable_of[edge])
        even_sum += term

assert (ZZ(2) ** len(active_edges)) * response == (ZZ(2) ** len(vertices)) * even_sum
print("RESULT: PASS")
