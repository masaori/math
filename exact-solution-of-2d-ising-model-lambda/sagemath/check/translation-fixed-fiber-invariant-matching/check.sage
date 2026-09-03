"""平行移動固定ファイバーの候補グラフに固定部分群不変な完全マッチングがあるかを検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L=2 で、置換を持つ全ファイバー鍵のうち非零平行移動の固定部分群が非自明な
ものについて、まず一様被覆検査の対象（E に含まれ偶で単一ファイバーの巻き付き対が
1 になる偶部分グラフ H を持つもの）かを判定し、対象なら四スピン構造すべてで
位相寄与を反転する候補辺の集合（縮約しない全候補）を作り、固定部分群で不変な
完全マッチングの存在を判定する。

判定は次の同値に基づく（二部グラフ・辺が位相符号の正負を結ぶことを使う）。
不変な完全マッチング M があれば、対 (u,v) in M と固定部分群の元 s について
s・(u,v) in M が u の像を含むので、s・u=u ならば s・v=v。従って対の両端の
点別固定部分群は一致し、M は「点別固定部分群が一致する候補辺」だけを使い、
頂点軌道の商グラフの完全マッチングへ落ちる。逆に商の完全マッチングの各辺の
witness 候補辺 (u,v)（点別固定部分群が一致）を軌道で運ぶと、運んだ辺集合は
候補辺だけの不変な完全マッチングになる（運搬の well-defined 性は点別固定部分群の
一致から従う）。正の向きは lift を実際に構成して assert で確かめる。
計算は有限集合・有限写像と Q(zeta_8) の等号だけで行う。
"""

load("sagemath/check/even-subgraph-orbit-translation-stabilizer/check.sage")

all_shifts = [(a, b) for a in range(L) for b in range(L)]
zero_shift = (0, 0)


def translate_key(shift, key):
    a, b = shift
    return permutation_key(translate_permutation(a, b, permutation_from_key(key)))


def fiber_stabilizer(fiber_key):
    return tuple(
        shift for shift in all_shifts
        if shift == zero_shift
        or translate_fiber_key(shift[0], shift[1], fiber_key) == fiber_key
    )


def valid_translations(fiber_key):
    doubled, single = fiber_key
    return [
        subset for subset in selection_subsets
        if subset.issubset(single)
        and is_even_selection_subset(subset)
        and winding_pairing(single, subset) == 1
    ]


def all_phase_edge_set(fiber_key, translations):
    edges = set()
    unbalanced = 0
    for phi in all_fibers[fiber_key]:
        source_key = permutation_key(phi)
        for translation in translations:
            balanced, candidates = rewiring_candidates(phi, translation)
            if not balanced:
                unbalanced += 1
                continue
            for candidate in candidates:
                if all(
                    phase_contribution(candidate, a, b)
                    == -phase_contribution(phi, a, b)
                    for a in (0, 1) for b in (0, 1)
                ):
                    edges.add(frozenset({source_key, permutation_key(candidate)}))
    return edges, unbalanced


def has_perfect_bipartite_matching(positive, negative, adjacency):
    matched_right = {}

    def augment(left, seen):
        for right in sorted(adjacency[left]):
            if right in seen:
                continue
            seen.add(right)
            if right not in matched_right or augment(matched_right[right], seen):
                matched_right[right] = left
                return True
        return False

    size = 0
    for left in sorted(positive):
        if augment(left, set()):
            size += 1
    return size == len(positive) == len(negative), matched_right


fixed_counts_by_shift = {
    shift: sum(
        1 for fiber_key in all_fibers
        if translate_fiber_key(shift[0], shift[1], fiber_key) == fiber_key
    )
    for shift in nontrivial_translations
}
assert fixed_counts_by_shift == {(0, 1): 35, (1, 0): 35, (1, 1): 37}

nontrivially_stabilized = sorted(
    fiber_key for fiber_key in all_fibers
    if any(
        translate_fiber_key(shift[0], shift[1], fiber_key) == fiber_key
        for shift in nontrivial_translations
    )
)

unbalanced_total = 0
fiber_size_distribution = {}
stabilizer_order_distribution = {}
fibers_with_invariant = 0
fibers_without_invariant = 0
fibers_with_uncovered_vertex = 0
without_by_stabilizer_order = {}
fibers_without_valid_translation = 0
fibers_examined = 0
quotient_isolated_positive_distribution = {}
quotient_isolated_negative_distribution = {}
quotient_orbit_count_distribution = {}
scope_fixed_fibers = set()
for fiber_key in nontrivially_stabilized:
    translations = valid_translations(fiber_key)
    if not translations:
        # 一様被覆検査の対象外（対の相殺を要しないファイバー）。
        fibers_without_valid_translation += 1
        continue
    fibers_examined += 1
    scope_fixed_fibers.add(fiber_key)
    stabilizer = fiber_stabilizer(fiber_key)
    order = len(stabilizer)
    stabilizer_order_distribution[order] = (
        stabilizer_order_distribution.get(order, 0) + 1
    )
    keys = {permutation_key(phi): phi for phi in all_fibers[fiber_key]}
    fiber_size_distribution[len(keys)] = (
        fiber_size_distribution.get(len(keys), 0) + 1
    )
    # 固定部分群は各置換をファイバー内へ移し、四スピン構造の位相寄与を保つ。
    for shift in stabilizer:
        if shift == zero_shift:
            continue
        for key, phi in keys.items():
            image_key = translate_key(shift, key)
            assert image_key in keys
            assert all(
                phase_contribution(keys[image_key], a, b)
                == phase_contribution(phi, a, b)
                for a in (0, 1) for b in (0, 1)
            )
    edges, unbalanced = all_phase_edge_set(fiber_key, translations)
    unbalanced_total += unbalanced
    # 候補辺集合は固定部分群で不変（共変な全候補集合の制限）。
    for shift in stabilizer:
        if shift == zero_shift:
            continue
        assert {
            frozenset(translate_key(shift, key) for key in edge)
            for edge in edges
        } == edges
    positive = {
        key for key, phi in keys.items()
        if phase_contribution(phi, 0, 0) == K8(1)
    }
    negative = set(keys) - positive
    assert len(positive) == len(negative)
    # 候補辺は正位相と負位相を結ぶ（二部性）。
    for edge in edges:
        first, second = sorted(edge)
        assert (first in positive) != (second in positive)
    covered = {key for edge in edges for key in edge}
    if covered != set(keys):
        fibers_with_uncovered_vertex += 1

    def point_stabilizer(key):
        return frozenset(
            shift for shift in stabilizer if translate_key(shift, key) == key
        )

    def orbit_of(key):
        return tuple(sorted({translate_key(shift, key) for shift in stabilizer}))

    positive_orbits = {orbit_of(key) for key in positive}
    negative_orbits = {orbit_of(key) for key in negative}
    adjacency = {orb: set() for orb in positive_orbits}
    witness = {}
    for edge in edges:
        first, second = sorted(edge)
        u, v = (first, second) if first in positive else (second, first)
        if point_stabilizer(u) != point_stabilizer(v):
            continue
        pair = (orbit_of(u), orbit_of(v))
        adjacency[pair[0]].add(pair[1])
        witness.setdefault(pair, (u, v))
    reverse_adjacency = {orb: set() for orb in negative_orbits}
    for positive_orbit, neighbors in adjacency.items():
        for negative_orbit in neighbors:
            reverse_adjacency[negative_orbit].add(positive_orbit)
    isolated_positive = sum(not neighbors for neighbors in adjacency.values())
    isolated_negative = sum(not neighbors for neighbors in reverse_adjacency.values())
    assert all(len(orbit) == 2 for orbit in positive_orbits)
    assert {
        orbit for orbit, neighbors in reverse_adjacency.items() if not neighbors
    } == {orbit for orbit in negative_orbits if len(orbit) == 1}
    if len(keys) == 32:
        assert (isolated_positive, isolated_negative) == (4, 8)
    else:
        assert len(keys) == 288
        assert (isolated_positive, isolated_negative) == (0, 24)
    quotient_isolated_positive_distribution[isolated_positive] = (
        quotient_isolated_positive_distribution.get(isolated_positive, 0) + 1
    )
    quotient_isolated_negative_distribution[isolated_negative] = (
        quotient_isolated_negative_distribution.get(isolated_negative, 0) + 1
    )
    orbit_count = (len(positive_orbits), len(negative_orbits))
    quotient_orbit_count_distribution[orbit_count] = (
        quotient_orbit_count_distribution.get(orbit_count, 0) + 1
    )
    perfect, matched_right = has_perfect_bipartite_matching(
        positive_orbits, negative_orbits, adjacency
    )
    if perfect:
        fibers_with_invariant += 1
        # 商の完全マッチングを持ち上げ、不変な完全マッチングであることを確かめる。
        lifted = set()
        for neg_orbit, pos_orbit in matched_right.items():
            u, v = witness[(pos_orbit, neg_orbit)]
            for shift in stabilizer:
                lifted.add(
                    frozenset({translate_key(shift, u), translate_key(shift, v)})
                )
        assert all(edge in edges for edge in lifted)
        counts = {}
        for edge in lifted:
            for key in edge:
                counts[key] = counts.get(key, 0) + 1
        assert counts == {key: 1 for key in keys}
        for shift in stabilizer:
            assert {
                frozenset(translate_key(shift, key) for key in edge)
                for edge in lifted
            } == lifted
    else:
        fibers_without_invariant += 1
        without_by_stabilizer_order[order] = (
            without_by_stabilizer_order.get(order, 0) + 1
        )

assert fibers_examined + fibers_without_valid_translation == len(
    nontrivially_stabilized
)
assert fibers_with_invariant + fibers_without_invariant == fibers_examined
assert len(nontrivially_stabilized) == 89
assert fibers_without_valid_translation == 81
assert fibers_examined == 8
assert stabilizer_order_distribution == {2: 8}
assert fiber_size_distribution == {32: 4, 288: 4}
assert fibers_with_invariant == 0
assert fibers_without_invariant == 8
assert without_by_stabilizer_order == {2: 8}
assert fibers_with_uncovered_vertex == 0
assert unbalanced_total == 0
assert quotient_orbit_count_distribution == {(8, 12): 4, (72, 84): 4}
assert quotient_isolated_positive_distribution == {4: 4, 0: 4}
assert quotient_isolated_negative_distribution == {8: 4, 24: 4}
scope_fixed_counts_by_shift = {
    shift: sum(
        translate_fiber_key(shift[0], shift[1], fiber_key) == fiber_key
        for fiber_key in scope_fixed_fibers
    )
    for shift in nontrivial_translations
}
assert fibers_checked == 64
assert len(scope_fixed_fibers) == 8
assert scope_fixed_counts_by_shift == {(0, 1): 4, (1, 0): 4, (1, 1): 0}
print(f"fixed realized fibers by shift: {fixed_counts_by_shift}")
print(f"fibers with nontrivial stabilizer: {len(nontrivially_stabilized)}")
print(f"  without a valid even subgraph H: {fibers_without_valid_translation}")
print(f"  examined (uniform-cover scope): {fibers_examined}")
print(f"stabilizer order distribution: {stabilizer_order_distribution}")
print(f"fiber size distribution: {fiber_size_distribution}")
print(f"fibers with stabilizer-invariant perfect matching: {fibers_with_invariant}")
print(f"fibers without stabilizer-invariant perfect matching: "
      f"{fibers_without_invariant}")
print(f"fibers without invariant matching, by stabilizer order: "
      f"{without_by_stabilizer_order}")
print(f"quotient positive/negative orbit counts: "
      f"{quotient_orbit_count_distribution}")
print(f"isolated positive quotient orbits: "
      f"{quotient_isolated_positive_distribution}")
print(f"isolated negative quotient orbits: "
      f"{quotient_isolated_negative_distribution}")
print(f"nontrivial-character scope fibers: {fibers_checked}")
print(f"uniform-cover scope fixed fibers by shift: {scope_fixed_counts_by_shift}")
print(f"fibers with a candidate-free permutation: {fibers_with_uncovered_vertex}")
print(f"unbalanced (phi, H) pairs skipped: {unbalanced_total}")
print("PASS: translation-fixed-fiber-invariant-matching")
