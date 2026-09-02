"""局所変更の形（一頂点の後続交換・二頂点の交差交換）と配置の型・一意性を検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L=2 で単一の偶部分グラフでは覆えない 16 ファイバーの符号反転候補辺を対象にする。
前の検算（even-subgraph-orbit-local-cut-join）で、変更される後続遷移は一つまたは
二つの頂点に二本ずつ局在することが分かった。ここでは次を調べる。

(1) 一頂点の候補で、二本の変更遷移が互いの後続を交換する互換
    （transported[e1] = phi[e2] かつ transported[e2] = phi[e1]）になっているか。
    （変更集合の像が保存されるので、これは局在の帰結でもある。数え上げで固定する。）
(2) 二頂点の候補で、各頂点の新しい後続の対が、もう一方の頂点の元の後続の対に
    一致するか（頂点間の交差交換）。
(3) 交換される二本の到着とその元の後続の基底辺が、反転対の辺集合 D・単純通過の
    辺集合 E・その外のどこに属するかの型の分布。
(4) 元の置換ごとの候補辺の本数と、一頂点候補の本数の分布
    （一意に定まる選択規則が取れるか）。
(5) 形（一頂点・二頂点）と軌道の変化（二分裂・合併）の対応表。

計算は有限集合と有限写像の等号だけで行う。
"""

load("sagemath/check/even-subgraph-orbit-local-cut-join/check.sage")


def membership(fiber_key, edge):
    doubled, single = fiber_key
    base = base_edge(edge)
    if base in doubled:
        return "D"
    if base in single:
        return "E"
    return "o"


one_vertex_swap = 0
one_vertex_other = 0
two_vertex_cross = 0
two_vertex_other = 0
two_vertex_own_distribution = {}
type_distribution = {}
shape_orbit_table = {}
candidate_count_by_source = {}
one_vertex_count_by_source = {}
sources = set()
for fiber_key in uncovered:
    for source_key, target_key in sorted(phase_edges_by_fiber[fiber_key]):
        phi = permutation_from_key(source_key)
        psi = permutation_from_key(target_key)
        transported = transported_permutation(phi, psi)
        changed = tuple(sorted(
            edge for edge in transported if transported[edge] != phi[edge]
        ))
        by_vertex = {}
        for edge in changed:
            by_vertex.setdefault(endpoints(L, edge)[1], []).append(edge)
        vertex_types = []
        for vertex, edges in sorted(by_vertex.items()):
            e1, e2 = sorted(edges)
            vertex_types.append((
                membership(fiber_key, e1),
                membership(fiber_key, e2),
                membership(fiber_key, phi[e1]),
                membership(fiber_key, phi[e2]),
            ))
        if len(by_vertex) == 1:
            (e1, e2), = (sorted(edges) for edges in by_vertex.values())
            if transported[e1] == phi[e2] and transported[e2] == phi[e1]:
                one_vertex_swap += 1
            else:
                one_vertex_other += 1
        else:
            pairs = [sorted(edges) for _, edges in sorted(by_vertex.items())]
            (e1, e2), (f1, f2) = pairs
            new_first = {transported[e1], transported[e2]}
            new_second = {transported[f1], transported[f2]}
            old_first = {phi[e1], phi[e2]}
            old_second = {phi[f1], phi[f2]}
            own_counts = (
                len(new_first & old_first),
                len(new_second & old_second),
            )
            if new_first == old_second and new_second == old_first:
                two_vertex_cross += 1
            else:
                two_vertex_other += 1
            two_vertex_own_distribution[own_counts] = (
                two_vertex_own_distribution.get(own_counts, 0) + 1
            )
        signature = (len(by_vertex), tuple(sorted(vertex_types)))
        type_distribution[signature] = type_distribution.get(signature, 0) + 1
        source_orbits = moved_orbits(phi)
        source_orbit_index = {
            edge: index
            for index, orbit in enumerate(source_orbits)
            for edge in orbit
        }
        first = changed[0]
        orbit_change = "split" if all(
            source_orbit_index[edge] == source_orbit_index[first]
            for edge in changed
        ) else "merge"
        shape_key = (len(by_vertex), orbit_change)
        shape_orbit_table[shape_key] = shape_orbit_table.get(shape_key, 0) + 1
        source = (fiber_key, source_key)
        sources.add(source)
        candidate_count_by_source[source] = (
            candidate_count_by_source.get(source, 0) + 1
        )
        if len(by_vertex) == 1:
            one_vertex_count_by_source[source] = (
                one_vertex_count_by_source.get(source, 0) + 1
            )

out_degree_distribution = {}
one_vertex_degree_distribution = {}
for source in sources:
    degree = candidate_count_by_source[source]
    out_degree_distribution[degree] = out_degree_distribution.get(degree, 0) + 1
    one_vertex_degree = one_vertex_count_by_source.get(source, 0)
    one_vertex_degree_distribution[one_vertex_degree] = (
        one_vertex_degree_distribution.get(one_vertex_degree, 0) + 1
    )

assert one_vertex_swap == 2816
assert one_vertex_other == 0
assert two_vertex_cross == 0
assert two_vertex_other == 1792
assert two_vertex_own_distribution == {(1, 1): 1792}
assert type_distribution == {
    (1, (("D", "E", "E", "D"),)): 896,
    (1, (("E", "D", "D", "E"),)): 896,
    (1, (("E", "E", "E", "E"),)): 1024,
    (2, (("D", "E", "E", "D"), ("E", "E", "E", "E"))): 896,
    (2, (("E", "D", "D", "E"), ("E", "E", "E", "E"))): 896,
}
assert len(sources) == 2624
assert out_degree_distribution == {1: 640, 2: 1984}
assert one_vertex_degree_distribution == {0: 576, 1: 1280, 2: 768}
assert shape_orbit_table == {
    (1, "split"): 2816,
    (2, "merge"): 512,
    (2, "split"): 1280,
}
print(f"one-vertex candidates that swap the two successors: {one_vertex_swap}")
print(f"one-vertex candidates of another form: {one_vertex_other}")
print(f"two-vertex candidates that cross-exchange the successor pairs: "
      f"{two_vertex_cross}")
print(f"two-vertex candidates of another form: {two_vertex_other}")
print(f"two-vertex own-pair intersection distribution: "
      f"{two_vertex_own_distribution}")
print(f"sources: {len(sources)}")
print(f"candidate out-degree distribution: {out_degree_distribution}")
print(f"one-vertex candidate count distribution: {one_vertex_degree_distribution}")
for signature in sorted(type_distribution):
    print(f"membership type {signature}: {type_distribution[signature]}")
for shape_key in sorted(shape_orbit_table):
    print(f"shape/orbit {shape_key}: {shape_orbit_table[shape_key]}")
print(f"PASS: even-subgraph-orbit-swap-rule "
      f"(edges={one_vertex_swap + one_vertex_other + two_vertex_cross + two_vertex_other})")
