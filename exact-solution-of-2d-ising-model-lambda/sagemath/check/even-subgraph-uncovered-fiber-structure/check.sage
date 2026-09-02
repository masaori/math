"""単一の偶部分グラフで覆えないファイバーの符号反転対応を構造別に検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L=2 で単一の偶部分グラフでは覆えない 16 ファイバーについて、置換ごとに
偶部分グラフを変える頂点組み替え候補の二部グラフを、置換の軌道長と接触対の配置を
保つ辺へ順に制限する。各制限後にも完全マッチングがあるかを有限集合の等号だけで調べる。
"""

load("sagemath/check/even-subgraph-fiberwise-uniform-matching/check.sage")


def orbit_index_map(phi):
    orbits = moved_orbits(phi)
    index = {}
    for number, orbit in enumerate(orbits):
        for edge in orbit:
            index[edge] = number
    return orbits, index


def orbit_length_signature(phi):
    return tuple(sorted(len(orbit) for orbit in moved_orbits(phi)))


def contact_placement_signature(phi, pairs):
    orbits, index = orbit_index_map(phi)
    placement = []
    for pair in pairs:
        edge, other = tuple(pair)
        first = index[edge]
        second = index[other]
        placement.append(tuple(sorted((len(orbits[first]), len(orbits[second])))))
    return tuple(sorted(placement))


def structural_signature(phi):
    return (
        orbit_length_signature(phi),
        contact_placement_signature(phi, contact_pairs(phi)),
        contact_placement_signature(phi, switchable_pairs(phi)),
    )


def matching_size_with_signature(fiber, edges, signature):
    keys = {permutation_key(phi): phi for phi in fiber}
    positive = {
        key for key, phi in keys.items()
        if phase_contribution(phi, 0, 0) == K8(1)
    }
    negative = set(keys) - positive
    adjacency = {key: set() for key in positive}
    for source, target in edges:
        if signature(keys[source]) != signature(keys[target]):
            continue
        if source in positive and target in negative:
            adjacency[source].add(target)
        if target in positive and source in negative:
            adjacency[target].add(source)
    perfect, size = has_perfect_matching(positive, negative, adjacency)
    return perfect, size, len(positive)


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

tests = (
    ("orbit lengths", orbit_length_signature),
    ("orbit lengths and all-contact placement",
     lambda phi: (orbit_length_signature(phi),
                  contact_placement_signature(phi, contact_pairs(phi)))),
    ("orbit lengths and all/switchable-contact placement", structural_signature),
)
perfect_counts = {name: 0 for name, _ in tests}
matched_vertices = {name: 0 for name, _ in tests}
total_vertices = 0
first_failures = {}
for fiber_key in uncovered:
    fiber = all_fibers[fiber_key]
    edges = phase_edges_by_fiber[fiber_key]
    total_vertices += len(fiber)
    for name, signature in tests:
        perfect, size, side_size = matching_size_with_signature(fiber, edges, signature)
        matched_vertices[name] += 2 * size
        if perfect:
            perfect_counts[name] += 1
        elif name not in first_failures:
            first_failures[name] = (fiber_key, 2 * side_size, 2 * size)

assert len(uncovered) == 16
assert total_vertices == 2816
assert perfect_counts == {name: 0 for name, _ in tests}
assert matched_vertices == {name: 0 for name, _ in tests}
for name, _ in tests:
    print(f"{name}: perfect fibers={perfect_counts[name]}, "
          f"matched vertices={matched_vertices[name]}/{total_vertices}")
    if name in first_failures:
        (doubled, single), vertices, matched = first_failures[name]
        print(f"first failure for {name}: D={sorted(doubled)}, E={sorted(single)}, "
              f"matched={matched}/{vertices}")
print(f"PASS: even-subgraph-uncovered-fiber-structure "
      f"(fibers={len(uncovered)}, vertices={total_vertices})")
