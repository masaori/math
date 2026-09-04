"""切断を横切る辺を動かすプラケット変形での同時変化を調べる。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-cut-contribution-topological/construction.sage")

def plaquette_edges(side, row, column):
    return frozenset([
        ("h", row, column),
        ("h", (row + 1) % side, column),
        ("v", row, column),
        ("v", row, (column + 1) % side),
    ])


def plaquette_cut_flags(side, row, column):
    return (ZZ(row == side - 1), ZZ(column == side - 1))


def plaquette_local_pattern(side, row, column, subset):
    pattern = []
    for delta_row in (0, 1):
        for delta_column in (-1, 0, 1):
            edge = ("h", (row + delta_row) % side, (column + delta_column) % side)
            if edge in subset:
                pattern.append(("h", delta_row, delta_column))
    for delta_row in (-1, 0, 1):
        for delta_column in (0, 1):
            edge = ("v", (row + delta_row) % side, (column + delta_column) % side)
            if edge in subset:
                pattern.append(("v", delta_row, delta_column))
    return tuple(sorted(pattern))


def key_selector(side, doubled, single):
    if side != 2:
        return frozenset()
    selectors = [
        selected for selected in base_edge_subsets
        if selected.issubset(single)
        and is_even_edge_subset(doubled.union(selected))
    ]
    return min(selectors, key=lambda item: tuple(sorted(item)))


def key_terms(side, doubled, single):
    orientations = curved_free_orientations(side, single)
    standard, _ = standard_orientation(side, single, orientations)
    moved = active_edges(doubled, single, standard)
    assigned, disjoint_sum = incident_pair_assignment(side, moved)
    vertices = sorted({vertex for edge in moved
                       for vertex in endpoints(side, edge)})
    product_value = K8(1)
    for vertex in vertices:
        determinant = vertex_local_determinant(side, moved, vertex)
        product_value *= determinant * K8(ZZ(-1) ** assigned.get(vertex, ZZ(0)))
    n_four = degree_four_count(side, single) if single else ZZ(0)
    normalized = product_value / K8(ZZ(2) ** n_four)
    assert normalized in (K8(1), K8(-1))
    vertex_exp = ZZ(normalized == K8(-1))
    selector = key_selector(side, doubled, single)
    target = target_exponent(side, doubled, single, selector)
    moved_parity = ZZ(len(moved)) % 2
    assert (moved_parity + vertex_exp + disjoint_sum) % 2 == target
    return moved_parity, vertex_exp, disjoint_sum, target


for side in (2, 3):
    keys = collect_keys(side)
    key_set = set(keys)
    terms = {}
    for doubled, single in keys:
        terms[(doubled, single)] = key_terms(side, doubled, single)

    deformation_count = ZZ(0)
    cut_deformation_count = ZZ(0)
    flag_only_classes = {}
    local_classes = {}
    local_with_d_classes = {}
    reduced_classes = {}
    for doubled, single in keys:
        base_terms = terms[(doubled, single)]
        for row in range(side):
            for column in range(side):
                plaquette = plaquette_edges(side, row, column)
                deformed = frozenset(single.symmetric_difference(plaquette))
                if (doubled, deformed) not in key_set:
                    continue
                new_terms = terms[(doubled, deformed)]
                change = tuple(
                    (new_value + old_value) % 2
                    for new_value, old_value in zip(new_terms, base_terms))
                flags = plaquette_cut_flags(side, row, column)
                pattern = plaquette_local_pattern(side, row, column, single)
                doubled_pattern = plaquette_local_pattern(
                    side, row, column, doubled)
                flag_only_classes.setdefault(flags, set()).add(change)
                local_classes.setdefault(
                    (flags, pattern), set()).add(change)
                local_with_d_classes.setdefault(
                    (flags, pattern, doubled_pattern), set()).add(change)
                reduced = (change[0], (change[1] + change[2]) % 2, change[3])
                reduced_classes.setdefault(
                    (flags, pattern, doubled_pattern), set()).add(reduced)
                deformation_count += 1
                if flags != (ZZ(0), ZZ(0)):
                    cut_deformation_count += 1

    mixed_flag_only = sum(
        1 for values in flag_only_classes.values() if len(values) > 1)
    mixed_local = sum(
        1 for values in local_classes.values() if len(values) > 1)
    mixed_local_with_d = sum(
        1 for values in local_with_d_classes.values() if len(values) > 1)
    mixed_reduced = sum(
        1 for values in reduced_classes.values() if len(values) > 1)
    component_varies = [ZZ(0)] * 4
    for values in local_with_d_classes.values():
        if len(values) <= 1:
            continue
        for index in range(4):
            if len({value[index] for value in values}) > 1:
                component_varies[index] += 1
