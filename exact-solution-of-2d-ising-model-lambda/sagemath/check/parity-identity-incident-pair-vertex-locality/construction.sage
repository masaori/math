"""共有端点対の寄与と頂点局所位相を合わせた頂点量の局所性を調べる。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-active-pair-orbit-cut-decomposition/construction.sage")

def vertex_slot_states(side, vertex, moved):
    row, column = vertex
    slots = (
        ("up", ("v", (row - 1) % side, column)),
        ("down", ("v", row, column)),
        ("left", ("h", row, (column - 1) % side)),
        ("right", ("h", row, column)),
    )
    states = []
    for name, base in slots:
        state = []
        for direction in (0, 1):
            edge = base + (direction,)
            if edge not in moved:
                continue
            source, target = endpoints(side, edge)
            if source == vertex:
                state.append("out")
            else:
                assert target == vertex
                state.append("in")
        states.append((name, tuple(sorted(state))))
    return tuple(states)


def vertex_wrap_flags(side, vertex):
    row, column = vertex
    return (
        ZZ(row == 0),
        ZZ(row == side - 1),
        ZZ(column == 0),
        ZZ(column == side - 1),
    )


def vertex_local_determinant(side, moved, vertex):
    incoming = sorted(
        edge for edge in moved if endpoints(side, edge)[1] == vertex)
    outgoing = sorted(
        edge for edge in moved if endpoints(side, edge)[0] == vertex)
    assert len(incoming) == len(outgoing)
    local_matrix = matrix(K8, [
        [K8(transition_entry(side, 0, 0, edge, successor))
         for successor in outgoing]
        for edge in incoming
    ])
    return local_matrix.det()


def incident_pair_assignment(side, moved):
    ordered = sorted(moved)
    assigned = {}
    disjoint_sum = ZZ(0)
    for left_index in range(len(ordered)):
        for right_index in range(left_index + 1, len(ordered)):
            left = ordered[left_index]
            right = ordered[right_index]
            shared = set(endpoints(side, left)).intersection(
                endpoints(side, right))
            value = pair_contribution(side, left, right)
            if shared:
                vertex = min(shared)
                assigned[vertex] = (assigned.get(vertex, ZZ(0)) + value) % 2
            else:
                disjoint_sum += value
    return assigned, disjoint_sum % 2


def collect_keys(side):
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
        return keys
    return [
        (frozenset(), single)
        for single in sorted(
            even_subgraphs_three, key=lambda item: tuple(sorted(item)))
        if single
        and character_is_trivial_general(side, single)
        and curved_free_orientations(side, single)
    ]


for side in (2, 3):
    classes = {}
    unflagged = {}
    vertex_total = ZZ(0)
    key_total = ZZ(0)
    for doubled, single in collect_keys(side):
        orientations = curved_free_orientations(side, single)
        standard, _ = standard_orientation(side, single, orientations)
        moved = active_edges(doubled, single, standard)
        assigned, disjoint_sum = incident_pair_assignment(side, moved)
        vertices = sorted({vertex for edge in moved
                           for vertex in endpoints(side, edge)})
        product_value = K8(1)
        incident_total = ZZ(0)
        for vertex in vertices:
            determinant = vertex_local_determinant(side, moved, vertex)
            incident = assigned.get(vertex, ZZ(0))
            weighted = determinant * K8(ZZ(-1) ** incident)
            signature = vertex_slot_states(side, vertex, moved)
            flags = vertex_wrap_flags(side, vertex)
            classes.setdefault((signature, flags), set()).add(weighted)
            unflagged.setdefault(signature, set()).add(weighted)
            product_value *= weighted
            incident_total += incident
            vertex_total += 1

        n_four = degree_four_count(side, single) if single else ZZ(0)
        normalized = (product_value * K8(ZZ(-1) ** disjoint_sum)
                      / K8(ZZ(2) ** n_four))
        reconstructed = (ZZ(len(moved)) + ZZ(normalized == K8(-1))) % 2
        key_total += 1

    mixed_flagged = sorted(
        key for key, values in classes.items() if len(values) > 1)
    mixed_unflagged = sorted(
        key for key, values in unflagged.items() if len(values) > 1)
