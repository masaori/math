"""二候補を切断・接合位置のデータでどこまで区別できるかを検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L=2 の単一の偶部分グラフでは覆えない 16 ファイバーで、候補を二本持つ
置換について、二候補の変更頂点、変更到着、変更する後続遷移を順に比較する。
計算は有限集合と有限写像の等号だけで行う。
"""

load("sagemath/check/even-subgraph-orbit-candidate-discrimination/check.sage")


def candidate_location_record(phi, psi):
    transported = transported_permutation(phi, psi)
    changed = tuple(sorted(
        edge for edge in transported if transported[edge] != phi[edge]
    ))
    vertices = tuple(sorted({endpoints(L, edge)[1] for edge in changed}))
    base_arrivals = tuple(sorted(base_edge(edge) for edge in changed))
    transitions = tuple(sorted(
        (edge, phi[edge], transported[edge]) for edge in changed
    ))
    return vertices, changed, base_arrivals, transitions


location_records_by_source = {}
for fiber_key in uncovered:
    for source_key, target_key in sorted(phase_edges_by_fiber[fiber_key]):
        phi = permutation_from_key(source_key)
        psi = permutation_from_key(target_key)
        location_records_by_source.setdefault((fiber_key, source_key), []).append(
            candidate_location_record(phi, psi)
        )

two_candidate_count = 0
same_vertex_count = 0
same_oriented_arrival_count = 0
same_base_arrival_count = 0
same_transition_count = 0
for records in location_records_by_source.values():
    if len(records) == 1:
        continue
    assert len(records) == 2
    two_candidate_count += 1
    first, second = records
    if first[0] == second[0]:
        same_vertex_count += 1
    if first[1] == second[1]:
        same_oriented_arrival_count += 1
    if first[2] == second[2]:
        same_base_arrival_count += 1
    if first[3] == second[3]:
        same_transition_count += 1

assert two_candidate_count == 1984
assert same_vertex_count == 192
assert same_oriented_arrival_count == 192
assert same_base_arrival_count == 192
assert same_transition_count == 192

print(f"two-candidate sources: {two_candidate_count}")
print(f"same changed-vertex set: {same_vertex_count}")
print(f"same changed oriented-arrival set: {same_oriented_arrival_count}")
print(f"same changed base-edge multiset: {same_base_arrival_count}")
print(f"same changed-transition data: {same_transition_count}")
print("PASS: even-subgraph-orbit-cut-location")
