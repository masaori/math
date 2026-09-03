"""衝突森の各成分に接する残りの候補辺の配置を検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L=2 の共変な全候補集合で、一意な一頂点候補の選択辺 1,280 本が作る森
（長さ 4 の道 32 個と、中心から四本の長さ 2 の腕が出る木 144 個）について、
次を数える。
(1) 各中心（入次数 2 または 4 の頂点）が候補元か、候補元なら一頂点候補と
    候補全体を何本持つか。
(2) 森の頂点に接する残りの候補辺（全 6,400 本の無向対から選択辺 1,280 本を
    除いたもの）が、同じ成分の中に留まるか、別の成分へ渡るか、森の外の頂点へ
    出るかの内訳（局在頂点数別）。
(3) 各成分に対する内部の残候補・外へ出る残候補の本数の分布。
計算は有限集合・有限写像と Q(zeta_8) の等号だけで行う。
"""

load("sagemath/check/even-subgraph-orbit-locality-collision/check.sage")


components = []
unseen_vertices = set(selected_vertices)
while unseen_vertices:
    start = next(iter(unseen_vertices))
    component = set()
    frontier = [start]
    while frontier:
        vertex = frontier.pop()
        if vertex in component:
            continue
        component.add(vertex)
        frontier.extend(undirected_adjacency[vertex] - component)
    unseen_vertices -= component
    components.append(frozenset(component))

component_of = {}
for index, component in enumerate(components):
    for vertex in component:
        component_of[vertex] = index

assert len(components) == 176
assert sorted(len(component) for component in components).count(5) == 32
assert sorted(len(component) for component in components).count(9) == 144

centers = [vertex for vertex in selected_vertices if in_degree[vertex] >= 2]
center_profile_distribution = {}
for center in centers:
    is_source = center in candidates_by_source
    one_vertex_count = len(one_vertex_by_source.get(center, []))
    candidate_count = len(candidates_by_source.get(center, []))
    profile = (in_degree[center], is_source, one_vertex_count, candidate_count)
    center_profile_distribution[profile] = (
        center_profile_distribution.get(profile, 0) + 1
    )

undirected_candidate_pairs = {}
for (fiber_key, source_key, target_key), (locality, kind) in edge_info.items():
    pair = frozenset({(fiber_key, source_key), (fiber_key, target_key)})
    undirected_candidate_pairs[pair] = (locality, kind)

assert len(undirected_candidate_pairs) == 6400

forest_pairs = {
    frozenset({source, target}) for source, target in selected_edges.items()
}
assert len(forest_pairs) == 1280

remaining_pair_placement_distribution = {}
internal_remaining_by_component = {index: 0 for index in range(len(components))}
outgoing_remaining_by_component = {index: 0 for index in range(len(components))}
for pair, (locality, kind) in undirected_candidate_pairs.items():
    if pair in forest_pairs:
        continue
    vertices = tuple(pair)
    touched_components = {
        component_of[vertex] for vertex in vertices if vertex in component_of
    }
    if len(touched_components) == 0:
        placement = "outside"
    elif len(touched_components) == 2:
        placement = "between components"
        for index in touched_components:
            outgoing_remaining_by_component[index] += 1
    elif all(vertex in component_of for vertex in vertices):
        placement = "inside one component"
        internal_remaining_by_component[next(iter(touched_components))] += 1
    else:
        placement = "component to exterior"
        outgoing_remaining_by_component[next(iter(touched_components))] += 1
    key = (locality, kind, placement)
    remaining_pair_placement_distribution[key] = (
        remaining_pair_placement_distribution.get(key, 0) + 1
    )

internal_count_distribution = {}
outgoing_count_distribution = {}
per_component_profile_distribution = {}
for index, component in enumerate(components):
    internal = internal_remaining_by_component[index]
    outgoing = outgoing_remaining_by_component[index]
    internal_count_distribution[internal] = (
        internal_count_distribution.get(internal, 0) + 1
    )
    outgoing_count_distribution[outgoing] = (
        outgoing_count_distribution.get(outgoing, 0) + 1
    )
    profile = (len(component), internal, outgoing)
    per_component_profile_distribution[profile] = (
        per_component_profile_distribution.get(profile, 0) + 1
    )

center_internal_incident_distribution = {}
center_external_incident_distribution = {}
for center in centers:
    internal_incident = 0
    external_incident = 0
    for pair, (locality, kind) in undirected_candidate_pairs.items():
        if pair in forest_pairs or center not in pair:
            continue
        other = next(iter(pair - {center}))
        if other in component_of and component_of[other] == component_of[center]:
            internal_incident += 1
        else:
            external_incident += 1
    profile = (in_degree[center], internal_incident, external_incident)
    center_internal_incident_distribution[profile] = (
        center_internal_incident_distribution.get(profile, 0) + 1
    )
    external_key = (in_degree[center], external_incident)
    center_external_incident_distribution[external_key] = (
        center_external_incident_distribution.get(external_key, 0) + 1
    )

print(f"components: {len(components)}")
print(f"center profile (in-degree, is source, one-vertex candidates, candidates) "
      f"distribution: {sorted(center_profile_distribution.items())}")
print(f"remaining pair (locality, kind, placement) distribution: "
      f"{sorted(remaining_pair_placement_distribution.items())}")
print(f"per-component internal remaining count distribution: "
      f"{sorted(internal_count_distribution.items())}")
print(f"per-component outgoing remaining count distribution: "
      f"{sorted(outgoing_count_distribution.items())}")
print(f"per-component (size, internal, outgoing) distribution: "
      f"{sorted(per_component_profile_distribution.items())}")
print(f"center (in-degree, internal incident, external incident) distribution: "
      f"{sorted(center_internal_incident_distribution.items())}")

assert center_profile_distribution == {
    (2, False, 0, 0): 32,
    (4, False, 0, 0): 144,
}
assert remaining_pair_placement_distribution == {
    (1, "split", "component to exterior"): 1504,
    (1, "split", "outside"): 32,
    (2, "merge", "component to exterior"): 512,
    (2, "merge", "outside"): 512,
    (2, "split", "between components"): 640,
    (2, "split", "component to exterior"): 1280,
    (2, "split", "outside"): 640,
}
assert internal_count_distribution == {0: 176}
assert outgoing_count_distribution == {8: 32, 30: 144}
assert per_component_profile_distribution == {(5, 0, 8): 32, (9, 0, 30): 144}
assert center_internal_incident_distribution == {
    (2, 0, 2): 32,
    (4, 0, 2): 144,
}
assert center_external_incident_distribution == {(2, 2): 32, (4, 2): 144}

print("PASS: even-subgraph-orbit-collision-forest-context")
