"""軌道の分裂・合併で変わる後続遷移の頂点配置を検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L=2 で単一の偶部分グラフでは覆えない 16 ファイバーの符号反転候補辺を対象にする。
像の置換を元の置換の動く向き付き辺集合へ引き戻したあと、二つの置換の異なる遷移を
数える。各変更頂点で異なる遷移がちょうど二つなら、前の検算で見つけた一軌道の二分裂・
二軌道の合併は、一つまたは二つの頂点に局在する接続変更として探せる。
計算は有限集合と有限写像の等号だけで行う。
"""

load("sagemath/check/even-subgraph-orbit-splitting/check.sage")


def transported_permutation(phi, psi):
    """psi を phi の動く向き付き辺集合上の置換へ共役して返す。"""
    moved_phi = {edge for edge in oriented if phi[edge] != edge}
    moved_psi = {edge for edge in oriented if psi[edge] != edge}
    pullback = {}
    for edge in moved_psi:
        pullback[edge] = edge if edge in moved_phi else reversal(edge)
    assert set(pullback.values()) == moved_phi
    inverse_pullback = {image: edge for edge, image in pullback.items()}
    assert len(inverse_pullback) == len(pullback)
    return {
        edge: pullback[psi[inverse_pullback[edge]]]
        for edge in moved_phi
    }


changed_count_distribution = {}
local_shape_distribution = {}
split_count = 0
merge_count = 0
edge_count = 0
for fiber_key in uncovered:
    for source_key, target_key in sorted(phase_edges_by_fiber[fiber_key]):
        edge_count += 1
        phi = permutation_from_key(source_key)
        psi = permutation_from_key(target_key)
        transported = transported_permutation(phi, psi)
        changed = tuple(sorted(
            edge for edge in transported if transported[edge] != phi[edge]
        ))
        changed_count_distribution[len(changed)] = (
            changed_count_distribution.get(len(changed), 0) + 1
        )
        vertices = {}
        for edge in changed:
            vertex = endpoints(L, edge)[1]
            vertices[vertex] = vertices.get(vertex, 0) + 1
        assert all(count == 2 for count in vertices.values())
        local_shape = (len(changed), len(vertices), tuple(sorted(vertices.values())))
        local_shape_distribution[local_shape] = (
            local_shape_distribution.get(local_shape, 0) + 1
        )
        source_orbits = moved_orbits(phi)
        source_orbit_index = {
            edge: index
            for index, orbit in enumerate(source_orbits)
            for edge in orbit
        }
        first = changed[0]
        if all(
            source_orbit_index[edge] == source_orbit_index[first]
            for edge in changed
        ):
            split_count += 1
        else:
            merge_count += 1

assert edge_count == 4608
assert changed_count_distribution == {2: 2816, 4: 1792}
assert local_shape_distribution == {
    (2, 1, (2,)): 2816,
    (4, 2, (2, 2)): 1792,
}
assert split_count == 4096
assert merge_count == 512
print(f"candidate edges: {edge_count}")
print(f"changed successor count distribution: {changed_count_distribution}")
for local_shape in sorted(local_shape_distribution):
    print(f"local shape {local_shape}: {local_shape_distribution[local_shape]}")
print(f"cuts within one orbit: {split_count}")
print(f"joins between two orbits: {merge_count}")
print(f"PASS: even-subgraph-orbit-local-cut-join (edges={edge_count})")
