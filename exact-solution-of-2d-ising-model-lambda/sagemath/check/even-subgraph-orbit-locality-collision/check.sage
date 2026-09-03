"""一頂点候補の一意選択が衝突する場合の有向グラフ構造を検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L=2 の共変な全候補集合で、一頂点変更の候補が一意な候補元からその候補へ
有向辺を張る。前段で見つかった 640 本の衝突辺について、次の選択まで追った鎖、
入次数、無向化した連結成分、二段の変更頂点の関係を数える。
計算は有限集合・有限写像と Q(zeta_8) の等号だけで行う。
"""

load("sagemath/check/even-subgraph-orbit-locality-selection/check.sage")


def changed_vertices_for_edge(source_key, target_key):
    phi = permutation_from_key(source_key)
    psi = permutation_from_key(target_key)
    transported = transported_permutation(phi, psi)
    return frozenset(
        endpoints(L, edge)[1]
        for edge in transported
        if transported[edge] != phi[edge]
    )


selected_edges = {
    source: (source[0], target_key)
    for source, target_key in unique_one_vertex_selection.items()
}
selected_vertices = set(selected_edges)
selected_vertices.update(selected_edges.values())

in_degree = {vertex: 0 for vertex in selected_vertices}
undirected_adjacency = {vertex: set() for vertex in selected_vertices}
for source, target in selected_edges.items():
    in_degree[target] += 1
    undirected_adjacency[source].add(target)
    undirected_adjacency[target].add(source)

in_degree_distribution = {}
for degree in in_degree.values():
    in_degree_distribution[degree] = in_degree_distribution.get(degree, 0) + 1

component_size_distribution = {}
component_degree_multisets = {}
unseen = set(selected_vertices)
while unseen:
    start = next(iter(unseen))
    component = set()
    frontier = [start]
    while frontier:
        vertex = frontier.pop()
        if vertex in component:
            continue
        component.add(vertex)
        frontier.extend(undirected_adjacency[vertex] - component)
    unseen -= component
    size = len(component)
    degrees = tuple(sorted(len(undirected_adjacency[vertex]) for vertex in component))
    component_size_distribution[size] = component_size_distribution.get(size, 0) + 1
    component_degree_multisets[degrees] = component_degree_multisets.get(degrees, 0) + 1

internal_edges = {
    source: target
    for source, target in selected_edges.items()
    if target in selected_edges
}
two_step_exit_count = 0
two_step_stays_inside_count = 0
same_changed_vertex_count = 0
different_changed_vertex_count = 0
for source, middle in internal_edges.items():
    target = selected_edges[middle]
    if target in selected_edges:
        two_step_stays_inside_count += 1
    else:
        two_step_exit_count += 1
    first_vertices = changed_vertices_for_edge(source[1], middle[1])
    second_vertices = changed_vertices_for_edge(middle[1], target[1])
    assert len(first_vertices) == 1
    assert len(second_vertices) == 1
    if first_vertices == second_vertices:
        same_changed_vertex_count += 1
    else:
        different_changed_vertex_count += 1

print(f"vertices incident to a unique one-vertex selection: {len(selected_vertices)}")
print(f"selected-edge target in-degree distribution: {sorted(in_degree_distribution.items())}")
print(f"undirected component size distribution: {sorted(component_size_distribution.items())}")
print(f"undirected component degree multisets: {sorted(component_degree_multisets.items())}")
print(f"selected edges whose target also selects: {len(internal_edges)}")
print(f"two-step chains that exit the selecting sources: {two_step_exit_count}")
print(f"two-step chains that remain among selecting sources: {two_step_stays_inside_count}")
print(f"two-step chains changing the same vertex twice: {same_changed_vertex_count}")
print(f"two-step chains changing different vertices: {different_changed_vertex_count}")

assert len(selected_edges) == 1280
assert len(internal_edges) == 640
assert len(selected_vertices) == 1456
assert in_degree_distribution == {0: 640, 1: 640, 2: 32, 4: 144}
assert component_size_distribution == {5: 32, 9: 144}
assert component_degree_multisets == {
    (1, 1, 2, 2, 2): 32,
    (1, 1, 1, 1, 2, 2, 2, 2, 4): 144,
}
assert two_step_exit_count == 640
assert two_step_stays_inside_count == 0
assert same_changed_vertex_count == 0
assert different_changed_vertex_count == 640

print("PASS: even-subgraph-orbit-locality-collision")
