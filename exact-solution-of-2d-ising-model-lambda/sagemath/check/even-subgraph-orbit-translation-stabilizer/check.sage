"""二候補が平行移動の対称性で入れ替わるかを検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L=2 の単一の偶部分グラフでは覆えない 16 ファイバーで、候補を二本持つ置換に
ついて、(D, E, phi) を固定する非自明な平行移動が二候補を入れ替えるかを調べる。
入れ替える平行移動が存在する置換では、平行移動と可換な選択規則は二候補から
一方を選べない（対称性の障害）。あわせて、ファイバー (D, E) を固定する平行移動が
符号反転候補辺の集合そのものを保つことも検査する。
計算は有限集合と有限写像の等号だけで行う。
"""

load("sagemath/check/even-subgraph-orbit-cut-location/check.sage")


def translate_base_edge(a, b, base):
    kind, i, j = base
    return (kind, (i + a) % L, (j + b) % L)


def translate_oriented_edge(a, b, edge):
    kind, i, j, d = edge
    return (kind, (i + a) % L, (j + b) % L, d)


def translate_permutation(a, b, phi):
    return {
        translate_oriented_edge(a, b, edge):
            translate_oriented_edge(a, b, phi[edge])
        for edge in oriented
    }


nontrivial_translations = [(a, b) for a in range(L) for b in range(L)
                           if (a, b) != (0, 0)]


def translate_fiber_key(a, b, fiber_key):
    doubled, single = fiber_key
    return (frozenset(translate_base_edge(a, b, base) for base in doubled),
            frozenset(translate_base_edge(a, b, base) for base in single))


uncovered_set = set(uncovered)
translated_uncovered = {
    translate_fiber_key(a, b, fiber_key)
    for fiber_key in uncovered for a, b in nontrivial_translations
}
orbit_representatives = set()
seen_fibers = set()
for fiber_key in sorted(uncovered, key=lambda key: (sorted(key[0]), sorted(key[1]))):
    if fiber_key in seen_fibers:
        continue
    orbit_representatives.add(fiber_key)
    seen_fibers.add(fiber_key)
    for a, b in nontrivial_translations:
        seen_fibers.add(translate_fiber_key(a, b, fiber_key))

fiber_stabilizer_count = 0
phase_edge_set_preserved_count = 0
for fiber_key in uncovered:
    doubled, single = fiber_key
    for a, b in nontrivial_translations:
        if frozenset(translate_base_edge(a, b, base) for base in doubled) != doubled:
            continue
        if frozenset(translate_base_edge(a, b, base) for base in single) != single:
            continue
        fiber_stabilizer_count += 1
        translated_edges = {
            (permutation_key(translate_permutation(a, b, permutation_from_key(source_key))),
             permutation_key(translate_permutation(a, b, permutation_from_key(target_key))))
            for source_key, target_key in phase_edges_by_fiber[fiber_key]
        }
        if translated_edges == phase_edges_by_fiber[fiber_key]:
            phase_edge_set_preserved_count += 1

candidates_by_source = {}
for fiber_key in uncovered:
    for source_key, target_key in sorted(phase_edges_by_fiber[fiber_key]):
        candidates_by_source.setdefault((fiber_key, source_key), []).append(target_key)

two_candidate_count = 0
source_stabilizer_count = 0
swapped_count = 0
fixed_both_count = 0
for (fiber_key, source_key), targets in sorted(candidates_by_source.items()):
    if len(targets) == 1:
        continue
    assert len(targets) == 2
    two_candidate_count += 1
    doubled, single = fiber_key
    phi = permutation_from_key(source_key)
    has_stabilizer = False
    swaps = False
    fixes_both = False
    for a, b in nontrivial_translations:
        if frozenset(translate_base_edge(a, b, base) for base in doubled) != doubled:
            continue
        if frozenset(translate_base_edge(a, b, base) for base in single) != single:
            continue
        if permutation_key(translate_permutation(a, b, phi)) != source_key:
            continue
        has_stabilizer = True
        images = [permutation_key(translate_permutation(
            a, b, permutation_from_key(target_key))) for target_key in targets]
        if images == [targets[1], targets[0]]:
            swaps = True
        if images == targets:
            fixes_both = True
    if has_stabilizer:
        source_stabilizer_count += 1
    if swaps:
        swapped_count += 1
    if fixes_both:
        fixed_both_count += 1

assert two_candidate_count == 1984
assert fiber_stabilizer_count == 0
assert phase_edge_set_preserved_count == 0
assert source_stabilizer_count == 0
assert swapped_count == 0
assert fixed_both_count == 0
assert translated_uncovered == uncovered_set
assert len(orbit_representatives) == 4

covariant_phase_edge_set_count = 0
translated_phase_edges_valid_count = 0
translated_phase_edges_missing_count = 0
first_covariance_failure = None
for fiber_key in uncovered:
    for a, b in nontrivial_translations:
        translated_fiber_key = translate_fiber_key(a, b, fiber_key)
        translated_edges = {
            (permutation_key(translate_permutation(a, b, permutation_from_key(source_key))),
             permutation_key(translate_permutation(a, b, permutation_from_key(target_key))))
            for source_key, target_key in phase_edges_by_fiber[fiber_key]
        }
        destination_edges = phase_edges_by_fiber[translated_fiber_key]
        for source_key, target_key in translated_edges:
            source = permutation_from_key(source_key)
            target = permutation_from_key(target_key)
            assert doubled_and_single_sets(source) == translated_fiber_key
            assert doubled_and_single_sets(target) == translated_fiber_key
            assert all(
                phase_contribution(target, spin_a, spin_b)
                == -phase_contribution(source, spin_a, spin_b)
                for spin_a in (0, 1) for spin_b in (0, 1)
            )
            translated_phase_edges_valid_count += 1
        missing_count = len(translated_edges - destination_edges)
        translated_phase_edges_missing_count += missing_count
        if translated_edges == destination_edges:
            covariant_phase_edge_set_count += 1
        elif first_covariance_failure is None:
            first_covariance_failure = (
                fiber_key, (a, b), translated_fiber_key,
                len(translated_edges), len(destination_edges), missing_count,
            )

assert covariant_phase_edge_set_count == 20
assert translated_phase_edges_valid_count == 13824
assert translated_phase_edges_missing_count == 3584
assert first_covariance_failure is not None

print(f"fiber-stabilizing nontrivial translations: {fiber_stabilizer_count}")
print(f"  of which preserve the phase-edge set: {phase_edge_set_preserved_count}")
print(f"two-candidate sources: {two_candidate_count}")
print(f"  with a (D,E,phi)-stabilizing nontrivial translation: {source_stabilizer_count}")
print(f"  where some stabilizer swaps the two candidates: {swapped_count}")
print(f"  where some stabilizer fixes both candidates: {fixed_both_count}")
print(f"uncovered fibers closed under translation: {translated_uncovered == uncovered_set}")
print(f"translation orbits of uncovered fibers: {len(orbit_representatives)}")
print(f"covariant phase-edge sets: {covariant_phase_edge_set_count} / "
      f"{len(uncovered) * len(nontrivial_translations)}")
print(f"translated phase edges checked as valid: {translated_phase_edges_valid_count}")
print(f"translated valid edges absent from the recorded destination set: "
      f"{translated_phase_edges_missing_count}")
print(f"first covariance failure: {first_covariance_failure}")
print("PASS: even-subgraph-orbit-translation-stabilizer")
