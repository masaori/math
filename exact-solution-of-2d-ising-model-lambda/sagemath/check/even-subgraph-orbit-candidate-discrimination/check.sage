"""二頂点変更の受け渡しの配置と、二候補を分ける不変量を検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L=2 で単一の偶部分グラフでは覆えない 16 ファイバーの符号反転候補辺を対象にする。
前の検算（even-subgraph-orbit-swap-rule）で、二頂点変更 1,792 本では各頂点の新しい
後続対が自身の元の後続を一本と他方の元の後続を一本含むこと、候補元 2,624 置換のうち
1,984 個が候補を二本持つことが分かった。ここでは次を調べる。

(1) 二頂点変更で、各頂点の二本の変更到着のうち、どちらの到着が同じ頂点のもう一方の
    元の後続を受け取り（交差到着）、どちらが他方の頂点の元の後続を受け取るか（受領到着）
    を確定する。交差到着・受領到着・輸出される後続・受領する後続の基底辺が反転対の
    辺集合 D・単純通過の辺集合 E・その外のどこに属するかの型分布を数え、
    所属の型だけで交差到着と受領到着が区別できるか（同所属で曖昧になる頂点の数）を数える。
(2) 候補を二本持つ置換で、二候補の（変更頂点数, 軌道変化の形）の組の分布を数え、
    この形だけで二候補が区別できるか（同形の対の数）を数える。

計算は有限集合と有限写像の等号だけで行う。
"""

load("sagemath/check/even-subgraph-orbit-swap-rule/check.sage")

records_by_source = {}
vertex_type_distribution = {}
cross_foreign_same_membership = 0
two_vertex_count = 0
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
        shapes = component_shapes(phi, psi)
        assert len(shapes) == 1
        (phi_lengths, psi_lengths), = shapes
        if len(phi_lengths) == 1:
            change_shape = ("split",) + tuple(sorted(psi_lengths))
        else:
            change_shape = ("merge",) + tuple(sorted(phi_lengths))
        records_by_source.setdefault((fiber_key, source_key), []).append(
            (len(by_vertex), change_shape)
        )
        if len(by_vertex) != 2:
            assert change_shape[0] == "split" and change_shape[1] == 2
            continue
        two_vertex_count += 1
        pairs = {vertex: sorted(edges) for vertex, edges in by_vertex.items()}
        old_pairs = {
            vertex: {phi[e1], phi[e2]} for vertex, (e1, e2) in pairs.items()
        }
        for own, other in zip(sorted(pairs), reversed(sorted(pairs))):
            e1, e2 = pairs[own]
            cross_pairs = [
                (cross, noncross)
                for cross, noncross in ((e1, e2), (e2, e1))
                if transported[cross] == phi[noncross]
            ]
            assert len(cross_pairs) == 1
            (cross, noncross), = cross_pairs
            imported = transported[noncross]
            exported = phi[cross]
            assert imported in old_pairs[other]
            vertex_type = (
                membership(fiber_key, cross),
                membership(fiber_key, noncross),
                membership(fiber_key, exported),
                membership(fiber_key, imported),
            )
            vertex_type_distribution[vertex_type] = (
                vertex_type_distribution.get(vertex_type, 0) + 1
            )
            if vertex_type[0] == vertex_type[1]:
                cross_foreign_same_membership += 1

pair_signature_distribution = {}
identical_pair_count = 0
for source, records in records_by_source.items():
    if len(records) == 1:
        continue
    assert len(records) == 2
    pair = tuple(sorted(records))
    pair_signature_distribution[pair] = (
        pair_signature_distribution.get(pair, 0) + 1
    )
    if records[0] == records[1]:
        identical_pair_count += 1

assert two_vertex_count == 1792
assert len(records_by_source) == 2624
assert sum(
    1 for records in records_by_source.values() if len(records) == 2
) == 1984
assert vertex_type_distribution == {
    ("D", "E", "E", "E"): 896,
    ("E", "D", "D", "E"): 896,
    ("E", "E", "E", "D"): 896,
    ("E", "E", "E", "E"): 896,
}
assert cross_foreign_same_membership == 1792
assert identical_pair_count == 1056
assert pair_signature_distribution == {
    ((1, ("split", 2, 2)), (1, ("split", 2, 2))): 320,
    ((1, ("split", 2, 2)), (1, ("split", 2, 4))): 128,
    ((1, ("split", 2, 4)), (1, ("split", 2, 4))): 64,
    ((1, ("split", 2, 4)), (2, ("split", 2, 4))): 256,
    ((1, ("split", 2, 6)), (1, ("split", 2, 6))): 128,
    ((1, ("split", 2, 6)), (2, ("split", 2, 6))): 128,
    ((1, ("split", 2, 6)), (2, ("split", 4, 4))): 128,
    ((1, ("split", 2, 10)), (1, ("split", 2, 10))): 128,
    ((1, ("split", 2, 10)), (2, ("split", 2, 10))): 64,
    ((1, ("split", 2, 10)), (2, ("split", 4, 8))): 64,
    ((2, ("merge", 4, 4)), (2, ("merge", 4, 4))): 128,
    ((2, ("merge", 4, 8)), (2, ("merge", 4, 8))): 128,
    ((2, ("split", 2, 6)), (2, ("split", 2, 6))): 32,
    ((2, ("split", 2, 6)), (2, ("split", 4, 4))): 64,
    ((2, ("split", 2, 8)), (2, ("split", 4, 6))): 64,
    ((2, ("split", 4, 4)), (2, ("split", 4, 4))): 32,
    ((2, ("split", 4, 6)), (2, ("split", 4, 6))): 64,
    ((2, ("split", 4, 8)), (2, ("split", 4, 8))): 16,
    ((2, ("split", 4, 8)), (2, ("split", 6, 6))): 32,
    ((2, ("split", 6, 6)), (2, ("split", 6, 6))): 16,
}

print(f"two-vertex candidates: {two_vertex_count}")
print("vertex type distribution (cross, foreign, exported, imported):")
for vertex_type in sorted(vertex_type_distribution):
    print(f"  {vertex_type}: {vertex_type_distribution[vertex_type]}")
print(f"cross/foreign same membership vertices: {cross_foreign_same_membership}")
print(f"two-candidate sources: 1984, identical-signature pairs: {identical_pair_count}")
print("pair signature distribution:")
for pair in sorted(pair_signature_distribution):
    print(f"  {pair}: {pair_signature_distribution[pair]}")
print("PASS: even-subgraph-orbit-candidate-discrimination")
