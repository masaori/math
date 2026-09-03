"""共変な全候補集合の切断・接合位置（局在頂点数）による選択規則の候補を検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L=2 の単一の偶部分グラフでは覆えない 16 ファイバーの、全ての位相反転候補を
保持した共変な候補辺集合について、次を数える。
(1) 各候補辺の逆向き辺（終点を始点、始点を終点とする候補辺）が集合に含まれるか、
    含まれるときの局在頂点数・軌道変化の対応。
(2) 各候補元の候補のうち一頂点変更（局在頂点数 1）の本数の分布。
(3) 一頂点変更の候補がちょうど一本の候補元だけにその候補を選ばせる規則が、
    候補辺の両端で一致する（選んだ先も一意で、選び返す）か。
局在頂点数と軌道変化は平行移動で不変なので、この規則は候補が一意に定まる限り
平行移動と可換である。計算は有限集合・有限写像と Q(zeta_8) の等号だけで行う。
"""

load("sagemath/check/even-subgraph-orbit-all-phase-edges/check.sage")


edge_info = {}
for fiber_key in uncovered:
    for source_key, target_key in all_phase_edges_by_fiber[fiber_key]:
        phi = permutation_from_key(source_key)
        psi = permutation_from_key(target_key)
        transported = transported_permutation(phi, psi)
        changed = tuple(sorted(
            edge for edge in transported if transported[edge] != phi[edge]
        ))
        changed_vertices = set()
        for edge in changed:
            changed_vertices.add(endpoints(L, edge)[1])
        source_orbits = moved_orbits(phi)
        source_orbit_index = {
            edge: index
            for index, orbit in enumerate(source_orbits)
            for edge in orbit
        }
        first = changed[0]
        if all(source_orbit_index[edge] == source_orbit_index[first] for edge in changed):
            kind = "split"
        else:
            kind = "merge"
        edge_info[(fiber_key, source_key, target_key)] = (len(changed_vertices), kind)

locality_distribution = {}
kind_distribution = {}
for locality, kind in edge_info.values():
    locality_distribution[locality] = locality_distribution.get(locality, 0) + 1
    kind_distribution[kind] = kind_distribution.get(kind, 0) + 1

assert len(edge_info) == 6400
assert locality_distribution == {1: 2816, 2: 3584}
assert kind_distribution == {"split": 5376, "merge": 1024}

reverse_present_count = 0
reverse_pair_distribution = {}
for (fiber_key, source_key, target_key), (locality, kind) in edge_info.items():
    reverse = (fiber_key, target_key, source_key)
    if reverse in edge_info:
        reverse_present_count += 1
        reverse_locality, reverse_kind = edge_info[reverse]
        pair = (locality, kind, reverse_locality, reverse_kind)
        reverse_pair_distribution[pair] = reverse_pair_distribution.get(pair, 0) + 1

candidates_by_source = {}
one_vertex_by_source = {}
for (fiber_key, source_key, target_key), (locality, kind) in edge_info.items():
    source = (fiber_key, source_key)
    candidates_by_source.setdefault(source, []).append(target_key)
    if locality == 1:
        one_vertex_by_source.setdefault(source, []).append(target_key)

assert len(candidates_by_source) == 2624

one_vertex_count_distribution = {}
for source in candidates_by_source:
    count = len(one_vertex_by_source.get(source, []))
    one_vertex_count_distribution[count] = (
        one_vertex_count_distribution.get(count, 0) + 1
    )

unique_one_vertex_selection = {
    source: targets[0]
    for source, targets in one_vertex_by_source.items()
    if len(targets) == 1
}
mutual_selection_count = 0
target_not_a_source_count = 0
target_without_unique_selection_count = 0
target_selects_other_count = 0
for (fiber_key, source_key), target_key in unique_one_vertex_selection.items():
    target = (fiber_key, target_key)
    if target not in candidates_by_source:
        target_not_a_source_count += 1
    elif target not in unique_one_vertex_selection:
        target_without_unique_selection_count += 1
    elif unique_one_vertex_selection[target] == source_key:
        mutual_selection_count += 1
    else:
        target_selects_other_count += 1

print(f"distinct candidate edges: {len(edge_info)}")
print(f"edges whose reverse edge is present: {reverse_present_count}")
print(f"(locality, kind, reverse locality, reverse kind) distribution: "
      f"{sorted(reverse_pair_distribution.items())}")
print(f"one-vertex candidate count distribution over sources: "
      f"{sorted(one_vertex_count_distribution.items())}")
print(f"sources with a unique one-vertex candidate: {len(unique_one_vertex_selection)}")
print(f"mutual unique one-vertex selections: {mutual_selection_count}")
print(f"selected target is not a source: {target_not_a_source_count}")
print(f"selected target lacks a unique one-vertex candidate: "
      f"{target_without_unique_selection_count}")
print(f"selected target selects a different permutation: {target_selects_other_count}")

assert reverse_present_count == 0
assert reverse_pair_distribution == {}
assert one_vertex_count_distribution == {0: 576, 1: 1280, 2: 768}
assert len(unique_one_vertex_selection) == 1280
assert mutual_selection_count == 0
assert target_not_a_source_count == 640
assert target_without_unique_selection_count == 0
assert target_selects_other_count == 640

print("PASS: even-subgraph-orbit-locality-selection")
