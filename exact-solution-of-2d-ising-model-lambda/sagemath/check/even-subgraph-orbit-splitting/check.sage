"""単一の偶部分グラフで覆えないファイバーで、候補が軌道をどう分裂・合併するかを検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L=2 で単一の偶部分グラフでは覆えない 16 ファイバーの符号反転候補辺
（元の置換 phi と像の置換 psi の対）は、軌道長の多重集合を必ず変える
（even-subgraph-uncovered-fiber-structure）。ここでは変わり方そのものを調べる。

psi の動く向き付き辺は、E 上で向きが反転した分を反転写像で phi の動く向き付き辺集合へ
引き戻せる（D の辺は両向きが動き、E の辺は片向きだけが動くので、この引き戻しは全単射）。
引き戻した psi の軌道分割と phi の軌道分割は同じ有限集合の二つの分割になる。
二つの分割のブロックを頂点、共通元を持つ組を辺とする二部グラフの連結成分を取り、
各成分を（phi 側の軌道長の列, psi 側の軌道長の列）で分類する。phi 側と psi 側が
同一の一軌道からなる成分は自明（その軌道は組み替えに関与しない）とし、
非自明成分の形の分布を全候補辺で数える。計算は有限集合の等号だけで行う。
"""

load("sagemath/check/even-subgraph-fiberwise-uniform-matching/check.sage")


def permutation_from_key(key):
    return dict(zip(oriented, key))


def pulled_back_orbits(phi, psi):
    """psi の軌道を phi の動く向き付き辺集合の分割として引き戻す。"""
    moved_phi = {edge for edge in oriented if phi[edge] != edge}
    moved_psi = {edge for edge in oriented if psi[edge] != edge}
    pullback = {}
    for edge in moved_psi:
        if edge in moved_phi:
            pullback[edge] = edge
        else:
            reversed_edge = reversal(edge)
            assert reversed_edge in moved_phi
            pullback[edge] = reversed_edge
    assert set(pullback.values()) == moved_phi
    assert len(pullback) == len(moved_phi)
    return [frozenset(pullback[edge] for edge in orbit)
            for orbit in moved_orbits(psi)]


def component_shapes(phi, psi):
    """重なり二部グラフの非自明成分の形（phi 側軌道長列, psi 側軌道長列）の列。"""
    blocks_phi = [frozenset(orbit) for orbit in moved_orbits(phi)]
    blocks_psi = pulled_back_orbits(phi, psi)
    parent = list(range(len(blocks_phi) + len(blocks_psi)))

    def find(node):
        while parent[node] != node:
            parent[node] = parent[parent[node]]
            node = parent[node]
        return node

    for i, block_phi in enumerate(blocks_phi):
        for j, block_psi in enumerate(blocks_psi):
            if block_phi & block_psi:
                root_i = find(i)
                root_j = find(len(blocks_phi) + j)
                if root_i != root_j:
                    parent[root_j] = root_i
    members = {}
    for i, block in enumerate(blocks_phi):
        members.setdefault(find(i), ([], []))[0].append(len(block))
    for j, block in enumerate(blocks_psi):
        members.setdefault(find(len(blocks_phi) + j), ([], []))[1].append(len(block))
    shapes = []
    for phi_lengths, psi_lengths in members.values():
        if len(phi_lengths) == 1 and len(psi_lengths) == 1 \
                and phi_lengths == psi_lengths:
            continue
        shapes.append((tuple(sorted(phi_lengths)), tuple(sorted(psi_lengths))))
    return tuple(sorted(shapes))


uncovered = []
for fiber_key, fiber in sorted(all_fibers.items()):
    translations = sorted(
        (subset for subset in selection_subsets
         if subset.issubset(fiber_key[1])
         and is_even_selection_subset(subset)
         and winding_pairing(fiber_key[1], subset) == 1),
        key=sorted,
    )
    if not translations:
        continue
    if not any(
        all(phase_flipping_partners(phi, translation) for phi in fiber)
        for translation in translations
    ):
        uncovered.append(fiber_key)

edge_count = 0
signature_counts = {}
for fiber_key in uncovered:
    for source_key, target_key in sorted(phase_edges_by_fiber[fiber_key]):
        edge_count += 1
        phi = permutation_from_key(source_key)
        psi = permutation_from_key(target_key)
        signature = component_shapes(phi, psi)
        signature_counts[signature] = signature_counts.get(signature, 0) + 1

assert len(uncovered) == 16
assert edge_count == 4608
assert all(len(signature) == 1 for signature in signature_counts)
assert all(
    sum(signature[0][0]) == sum(signature[0][1])
    for signature in signature_counts
)
assert all(
    (len(signature[0][0]), len(signature[0][1])) in ((1, 2), (2, 1))
    for signature in signature_counts
)
assert signature_counts == {
    (((4,), (2, 2)),): 1024,
    (((6,), (2, 4)),): 1024,
    (((8,), (2, 6)),): 768,
    (((8,), (4, 4)),): 256,
    (((10,), (2, 8)),): 192,
    (((10,), (4, 6)),): 192,
    (((12,), (2, 10)),): 448,
    (((12,), (4, 8)),): 128,
    (((12,), (6, 6)),): 64,
    (((4, 4), (8,)),): 256,
    (((4, 8), (12,)),): 256,
}
split_count = sum(
    count for signature, count in signature_counts.items()
    if len(signature[0][0]) == 1
)
merge_count = sum(
    count for signature, count in signature_counts.items()
    if len(signature[0][0]) == 2
)
assert split_count == 4096
assert merge_count == 512
print(f"uncovered fibers: {len(uncovered)}")
print(f"candidate edges: {edge_count}")
for signature in sorted(signature_counts):
    print(f"nontrivial components {signature}: {signature_counts[signature]}")
print(f"splits (one orbit into two): {split_count}")
print(f"merges (two orbits into one): {merge_count}")
print(f"PASS: even-subgraph-orbit-splitting "
      f"(fibers={len(uncovered)}, edges={edge_count})")
