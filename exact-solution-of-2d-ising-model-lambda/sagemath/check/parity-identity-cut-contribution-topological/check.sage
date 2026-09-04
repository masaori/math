"""切断依存項を巻き付き偶奇と交差対へまとめる有限検算。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

直前までに得た頂点局所量を、同じ局所配置を一辺五の内部頂点へ移した
基準値と比較する。頂点基準値からの符号差と、非共有端点対の軌道分解に
現れる座標切断横断項を合わせた切断依存項を取り出し、残る切断非依存項と
標的の巻き付き偶奇・交差対の関係を全鍵で調べる。
"""

load("sagemath/check/parity-identity-incident-pair-vertex-locality/check.sage")


def moved_at_interior(signature):
    side = 5
    vertex = (2, 2)
    bases = {
        "up": ("v", 1, 2),
        "down": ("v", 2, 2),
        "left": ("h", 2, 1),
        "right": ("h", 2, 2),
    }
    moved = set()
    for name, states in signature:
        for state in states:
            matches = []
            for direction in (0, 1):
                edge = bases[name] + (direction,)
                source, target = endpoints(side, edge)
                if ((state == "out" and source == vertex)
                        or (state == "in" and target == vertex)):
                    matches.append(edge)
            assert len(matches) == 1
            moved.add(matches[0])
    return frozenset(moved), vertex


def interior_vertex_weight(signature):
    moved, vertex = moved_at_interior(signature)
    assigned, _ = incident_pair_assignment(5, moved)
    determinant = vertex_local_determinant(5, moved, vertex)
    return determinant * K8(ZZ(-1) ** assigned.get(vertex, ZZ(0)))


def nonincident_orbit_parts(side, moved):
    grouped = {}
    ordered = sorted(moved)
    for left_index in range(len(ordered)):
        for right_index in range(left_index + 1, len(ordered)):
            left = ordered[left_index]
            right = ordered[right_index]
            if set(endpoints(side, left)).intersection(endpoints(side, right)):
                continue
            representative, shift = canonical_pair_with_shift(side, left, right)
            rep_left, rep_right = representative
            row_shift, column_shift = shift
            target_flip = lexicographic_cut_flip(
                side, endpoints(side, rep_left)[1], endpoints(side, rep_right)[1],
                row_shift, column_shift)
            source_flip = lexicographic_cut_flip(
                side, endpoints(side, rep_left)[0], endpoints(side, rep_right)[0],
                row_shift, column_shift)
            count, cut = grouped.get(representative, (ZZ(0), ZZ(0)))
            grouped[representative] = (
                count + 1, cut + target_flip + source_flip)
    representative_sum = ZZ(0)
    cut_sum = ZZ(0)
    for representative, (count, cut) in grouped.items():
        representative_sum += pair_contribution(side, *representative) * count
        cut_sum += cut
    return representative_sum % 2, cut_sum % 2


def cut_and_base_exponents(side, doubled, single):
    orientations = curved_free_orientations(side, single)
    standard, _ = standard_orientation(side, single, orientations)
    moved = active_edges(doubled, single, standard)
    assigned, _ = incident_pair_assignment(side, moved)
    vertices = sorted({vertex for edge in moved for vertex in endpoints(side, edge)})
    actual_product = K8(1)
    baseline_product = K8(1)
    for vertex in vertices:
        signature = vertex_slot_states(side, vertex, moved)
        actual = (vertex_local_determinant(side, moved, vertex)
                  * K8(ZZ(-1) ** assigned.get(vertex, ZZ(0))))
        baseline = interior_vertex_weight(signature)
        ratio = actual / baseline
        assert ratio in (K8(1), K8(-1))
        actual_product *= actual
        baseline_product *= baseline
    vertex_cut = ZZ(actual_product / baseline_product == K8(-1))
    representative_sum, pair_cut = nonincident_orbit_parts(side, moved)
    n_four = degree_four_count(side, single) if single else ZZ(0)
    normalized_baseline = baseline_product / K8(ZZ(2) ** n_four)
    assert normalized_baseline in (K8(1), K8(-1))
    base = (ZZ(len(moved)) + representative_sum
            + ZZ(normalized_baseline == K8(-1))) % 2
    cut = (vertex_cut + pair_cut) % 2
    return base, cut


records = {}
for side in (2, 3):
    count = ZZ(0)
    patterns = set()
    for doubled, single in collect_keys(side):
        selectors = [
            selected for selected in base_edge_subsets
            if selected.issubset(single)
            and is_even_edge_subset(doubled.union(selected))
        ] if side == 2 else [frozenset()]
        selector = min(selectors, key=lambda item: tuple(sorted(item)))
        base, cut = cut_and_base_exponents(side, doubled, single)
        target = target_exponent(side, doubled, single, selector)
        assert (base + cut) % 2 == target
        eh, ev = subset_parities(side, single)
        intersection = intersection_pairing(
            side, doubled.union(selector), single)
        patterns.add((eh, ev, intersection, base, cut, target))
        count += 1
    records[side] = (count, patterns)
    print("L=%d: keys=%d patterns=%s" % (side, count, sorted(patterns)))

    values_by_topology = {}
    for eh, ev, intersection, base, cut, target in patterns:
        values_by_topology.setdefault(
            (eh, ev, intersection, target), set()).add((base, cut))
    collisions = {
        topology: values for topology, values in values_by_topology.items()
        if len(values) > 1
    }
    print("L=%d: topological classes with multiple (base,cut) values=%d"
          % (side, len(collisions)))
    assert collisions

print("PASS: 内部頂点基準による切断依存項と切断非依存項の和は標的式に一致するが、"
      "各項は同じ巻き付き偶奇・交差対の中でも変わるため、この基準では切断依存項を"
      "位相量だけへ同定できない")
