"""動辺集合で制限した非共有端点対の和を軌道項と切断横断項へ分解する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

非共有端点を持つ有向辺対を同時に平行移動した軌道ごとにまとめる。
各軌道では辞書式最小の辺対を代表に取る。代表を (u,v) だけ平行移動した
とき、終点順序の反転指示値が変わるかどうかは、終点二つの辞書式順序が
座標の mod L 切断を横切って反転するかだけで決まる。始点についても同じ
である。従って、動辺集合に実際に含まれる対だけに制限した和は

  代表の寄与 × 動辺対の個数
  + 終点二つの切断横断数
  + 始点二つの切断横断数                         (mod 2)

へ分かれる。本検算はこの等式を軌道ごと、および全軌道の和について確かめる。
有限集合と F_2 の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-pair-locality/check.sage")


def translate_directed(side, edge, row_shift, column_shift):
    kind, row, column, orientation = edge
    return (kind, (row + row_shift) % side,
            (column + column_shift) % side, orientation)


def unordered_pair(left, right):
    return tuple(sorted((left, right)))


def canonical_pair_with_shift(side, left, right):
    orbit = {}
    for row_shift in range(side):
        for column_shift in range(side):
            translated = unordered_pair(
                translate_directed(side, left, row_shift, column_shift),
                translate_directed(side, right, row_shift, column_shift),
            )
            orbit.setdefault(translated, (row_shift, column_shift))
    representative = min(orbit)

    shifts_from_representative = {}
    rep_left, rep_right = representative
    for row_shift in range(side):
        for column_shift in range(side):
            translated = unordered_pair(
                translate_directed(side, rep_left, row_shift, column_shift),
                translate_directed(side, rep_right, row_shift, column_shift),
            )
            shifts_from_representative.setdefault(
                translated, (row_shift, column_shift))
    return representative, shifts_from_representative[unordered_pair(left, right)]


def lexicographic_cut_flip(side, first, second, row_shift, column_shift):
    """同じ平行移動で二点の辞書式順序が反転する指示値。"""
    if first[0] != second[0]:
        before = ZZ(first[0] > second[0])
        after = ZZ(
            (first[0] + row_shift) % side
            > (second[0] + row_shift) % side
        )
    else:
        before = ZZ(first[1] > second[1])
        after = ZZ(
            (first[1] + column_shift) % side
            > (second[1] + column_shift) % side
        )
    return (before + after) % 2


def active_nonincident_orbit_decomposition(side, moved):
    grouped = {}
    ordered = sorted(moved)
    for left_index in range(len(ordered)):
        for right_index in range(left_index + 1, len(ordered)):
            left = ordered[left_index]
            right = ordered[right_index]
            if set(endpoints(side, left)).intersection(endpoints(side, right)):
                continue
            representative, shift = canonical_pair_with_shift(
                side, left, right)
            rep_left, rep_right = representative
            row_shift, column_shift = shift
            target_flip = lexicographic_cut_flip(
                side,
                endpoints(side, rep_left)[1],
                endpoints(side, rep_right)[1],
                row_shift,
                column_shift,
            )
            source_flip = lexicographic_cut_flip(
                side,
                endpoints(side, rep_left)[0],
                endpoints(side, rep_right)[0],
                row_shift,
                column_shift,
            )
            representative_value = pair_contribution(
                side, rep_left, rep_right)
            actual = pair_contribution(side, left, right)
            assert actual == (
                representative_value + target_flip + source_flip
            ) % 2
            count, target_cuts, source_cuts, actual_sum = grouped.get(
                representative, (ZZ(0), ZZ(0), ZZ(0), ZZ(0)))
            grouped[representative] = (
                count + 1,
                target_cuts + target_flip,
                source_cuts + source_flip,
                actual_sum + actual,
            )

    corrected_orbits = ZZ(0)
    active_orbits = ZZ(0)
    pair_count = ZZ(0)
    actual_total = ZZ(0)
    decomposed_total = ZZ(0)
    for representative, values in grouped.items():
        count, target_cuts, source_cuts, actual_sum = values
        representative_value = pair_contribution(side, *representative)
        decomposed = (
            representative_value * count + target_cuts + source_cuts
        ) % 2
        assert decomposed == actual_sum % 2
        active_orbits += 1
        pair_count += count
        actual_total += actual_sum
        decomposed_total += decomposed
        corrected_orbits += ZZ((target_cuts + source_cuts) % 2 == 1)
    assert actual_total % 2 == decomposed_total % 2
    return active_orbits, corrected_orbits, pair_count


def active_edges(doubled, single, orientation):
    return frozenset(
        [base + (direction,) for base in doubled for direction in (0, 1)]
        + [base + (orientation[base],) for base in single]
    )


checks = {}
for side in (2, 3):
    total_keys = ZZ(0)
    total_orbits = ZZ(0)
    total_corrected = ZZ(0)
    total_pairs = ZZ(0)
    if side == 2:
        keys = []
        for doubled, single in sorted(all_fibers):
            selectors = [
                selected for selected in base_edge_subsets
                if selected.issubset(single)
                and is_even_edge_subset(doubled.union(selected))
            ]
            if selectors and character_is_trivial_general(side, single):
                keys.append((doubled, single))
    else:
        keys = [
            (frozenset(), single)
            for single in sorted(
                even_subgraphs_three, key=lambda item: tuple(sorted(item)))
            if single
            and character_is_trivial_general(side, single)
            and curved_free_orientations(side, single)
        ]
    for doubled, single in keys:
        orientations = curved_free_orientations(side, single)
        standard, _ = standard_orientation(side, single, orientations)
        orbit_count, corrected_count, pair_count = \
            active_nonincident_orbit_decomposition(
                side, active_edges(doubled, single, standard))
        total_keys += 1
        total_orbits += orbit_count
        total_corrected += corrected_count
        total_pairs += pair_count
    checks[side] = (total_keys, total_orbits, total_corrected, total_pairs)
    print("L=%d: keys=%d active-orbits=%d cut-corrected=%d active-pairs=%d"
          % ((side,) + checks[side]))
    assert total_keys > 0 and total_pairs > 0

print("PASS: 動辺集合で制限した非共有端点対の和を、軌道代表の寄与と"
      "終点・始点の座標切断横断数へ分解")
