# 対象ラベル: claim_two_dimensional_boundary_response_even_subgraph_sum
# L'=1, L=2 の四角形について、偶部分グラフと Fisher の terminal lattice の
# 完全マッチングが有限集合として全単射になることを確認する。
from itertools import combinations


def subsets(values):
    for size in range(len(values) + 1):
        for chosen in combinations(values, size):
            yield frozenset(chosen)


vertices = ((0, 0), (1, 0), (1, 1), (0, 1))
polygon_edges = tuple(
    frozenset((vertices[index], vertices[(index + 1) % len(vertices)]))
    for index in range(len(vertices))
)


def incident_edges(vertex):
    return tuple(edge for edge in polygon_edges if vertex in edge)


# 各 terminal は「元の頂点と、その頂点に接続する元の辺」の組である。
terminals = tuple((vertex, edge) for vertex in vertices for edge in incident_edges(vertex))
internal_edges = tuple(
    frozenset(((vertex, incident_edges(vertex)[0]), (vertex, incident_edges(vertex)[1])))
    for vertex in vertices
)
external_edges = tuple(
    frozenset((
        (tuple(edge)[0], edge),
        (tuple(edge)[1], edge),
    ))
    for edge in polygon_edges
)
terminal_edges = internal_edges + external_edges


def is_even_subgraph(chosen):
    return all(sum(edge in chosen for edge in incident_edges(vertex)) % 2 == 0 for vertex in vertices)


def is_perfect_matching(chosen):
    return all(sum(terminal in edge for edge in chosen) == 1 for terminal in terminals)


even_subgraphs = tuple(chosen for chosen in subsets(polygon_edges) if is_even_subgraph(chosen))
perfect_matchings = tuple(chosen for chosen in subsets(terminal_edges) if is_perfect_matching(chosen))


def matching_from_even_subgraph(chosen):
    matching = {
        external_edges[index]
        for index, edge in enumerate(polygon_edges)
        if edge not in chosen
    }
    for index, vertex in enumerate(vertices):
        if all(edge in chosen for edge in incident_edges(vertex)):
            matching.add(internal_edges[index])
    return frozenset(matching)


def even_subgraph_from_matching(chosen):
    return frozenset(
        edge
        for index, edge in enumerate(polygon_edges)
        if external_edges[index] not in chosen
    )


assert len(even_subgraphs) == 2
assert len(perfect_matchings) == 2
assert all(matching_from_even_subgraph(chosen) in perfect_matchings for chosen in even_subgraphs)
assert all(even_subgraph_from_matching(chosen) in even_subgraphs for chosen in perfect_matchings)
assert all(
    even_subgraph_from_matching(matching_from_even_subgraph(chosen)) == chosen
    for chosen in even_subgraphs
)
assert all(
    matching_from_even_subgraph(even_subgraph_from_matching(chosen)) == chosen
    for chosen in perfect_matchings
)

print("even subgraphs:", len(even_subgraphs))
print("perfect matchings:", len(perfect_matchings))
print("RESULT: PASS")
