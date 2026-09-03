"""全ての位相反転候補辺を保持した集合の平行移動共変性と局所形を検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L=2 の単一の偶部分グラフでは覆えない 16 ファイバーについて、各 (phi, H) で
最初に見つかった候補だけを残す縮約を行わず、四つのスピン構造で位相を反転する候補を
全て集める。その候補辺集合が平行移動と可換であることを全 48 組で確かめ、縮約集合で
観察した候補数と局所変更の形を全候補集合の上で数え直す。
計算は有限集合・有限写像と Q(zeta_8) の等号だけで行う。
"""

load("sagemath/check/even-subgraph-orbit-translation-stabilizer/check.sage")


all_phase_edges_by_fiber = {fiber_key: set() for fiber_key in uncovered}
for fiber_key in uncovered:
    doubled, single = fiber_key
    translations = sorted(
        (subset for subset in selection_subsets
         if subset.issubset(single)
         and is_even_selection_subset(subset)
         and winding_pairing(single, subset) == 1),
        key=sorted,
    )
    for phi in all_fibers[fiber_key]:
        source_key = permutation_key(phi)
        for translation in translations:
            balanced, candidates = rewiring_candidates(phi, translation)
            assert balanced
            for candidate in candidates:
                if all(
                    phase_contribution(candidate, a, b)
                    == -phase_contribution(phi, a, b)
                    for a in (0, 1) for b in (0, 1)
                ):
                    all_phase_edges_by_fiber[fiber_key].add(
                        (source_key, permutation_key(candidate))
                    )


covariant_pair_count = 0
for fiber_key in uncovered:
    for a, b in nontrivial_translations:
        translated_fiber_key = translate_fiber_key(a, b, fiber_key)
        translated_edges = {
            (permutation_key(translate_permutation(
                a, b, permutation_from_key(source_key))),
             permutation_key(translate_permutation(
                a, b, permutation_from_key(target_key))))
            for source_key, target_key in all_phase_edges_by_fiber[fiber_key]
        }
        assert translated_edges == all_phase_edges_by_fiber[translated_fiber_key]
        covariant_pair_count += 1


edge_count = 0
sources = set()
candidate_count_by_source = {}
changed_count_distribution = {}
local_shape_distribution = {}
split_count = 0
merge_count = 0
for fiber_key in uncovered:
    for source_key, target_key in all_phase_edges_by_fiber[fiber_key]:
        edge_count += 1
        source = (fiber_key, source_key)
        sources.add(source)
        candidate_count_by_source[source] = candidate_count_by_source.get(source, 0) + 1
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
        if all(source_orbit_index[edge] == source_orbit_index[first] for edge in changed):
            split_count += 1
        else:
            merge_count += 1

out_degree_distribution = {}
for source in sources:
    degree = candidate_count_by_source[source]
    out_degree_distribution[degree] = out_degree_distribution.get(degree, 0) + 1

print(f"uncovered fibers: {len(uncovered)}")
print(f"covariant all-candidate phase-edge sets: {covariant_pair_count} / 48")
print(f"sources with a phase-flipping candidate: {len(sources)}")
print(f"all distinct phase-flipping candidate edges: {edge_count}")
print(f"candidate out-degree distribution: {out_degree_distribution}")
print(f"changed successor count distribution: {changed_count_distribution}")
print(f"local shape distribution: {local_shape_distribution}")
print(f"splits (one orbit into two): {split_count}")
print(f"merges (two orbits into one): {merge_count}")

assert covariant_pair_count == 48
assert len(sources) == 2624
assert edge_count == 6400
assert out_degree_distribution == {1: 640, 2: 768, 3: 640, 4: 576}
assert changed_count_distribution == {2: 2816, 4: 3584}
assert local_shape_distribution == {
    (2, 1, (2,)): 2816,
    (4, 2, (2, 2)): 3584,
}
assert split_count == 5376
assert merge_count == 1024

print("PASS: even-subgraph-orbit-all-phase-edges")
