"""自明文字ファイバーの均衡配向類の位相和を局所頂点型で検査する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

一辺二の自明文字・選択非空ファイバーを、単純通過部分が誘導する
均衡配向ごとに類別する。各類について、次数 4 頂点の入方向が隣接する
曲がり型なら位相和が零であり、曲がり型が無ければ位相和の絶対値が
2^(直進型の次数 4 頂点数) に等しいことを、四つのスピン構造で検査する。
有限集合、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/trivial-character-fiber-orientation-classes/check.sage")


def directed_edge(base, orientation):
    return base + (orientation,)


def local_vertex_counts(single, orientation):
    curved = ZZ(0)
    straight = ZZ(0)
    for vertex in {(row, column) for row in range(L) for column in range(L)}:
        incident = [base for base in single if vertex in endpoints(L, base + (0,))]
        if len(incident) != 4:
            continue
        incoming = []
        outgoing = []
        for base in incident:
            edge = directed_edge(base, orientation[base])
            first, second = endpoints(L, edge)
            if first == vertex:
                outgoing.append(direction(edge))
            if second == vertex:
                incoming.append(direction(edge))
        assert len(incoming) == 2
        assert len(outgoing) == 2
        difference = (incoming[0] - incoming[1]) % 4
        if difference == 2:
            straight += 1
        else:
            assert difference in (1, 3)
            curved += 1
    return curved, straight


def ordering_sign(items, reordered):
    positions = {item: index for index, item in enumerate(items)}
    sequence = [positions[item] for item in reordered]
    inversions = sum(
        ZZ(sequence[left] > sequence[right])
        for left in range(len(sequence))
        for right in range(left + 1, len(sequence))
    )
    return ZZ(-1) ** inversions


def local_determinant_product(moved, a, b):
    ordered = sorted(moved)
    vertices = sorted({endpoints(L, edge)[0] for edge in ordered})
    row_order = sorted(ordered, key=lambda edge: (endpoints(L, edge)[1], edge))
    column_order = sorted(ordered, key=lambda edge: (endpoints(L, edge)[0], edge))
    row_sign = ordering_sign(ordered, row_order)
    column_sign = ordering_sign(ordered, column_order)
    product_value = K8(1)
    for vertex in vertices:
        incoming = [edge for edge in row_order if endpoints(L, edge)[1] == vertex]
        outgoing = [edge for edge in column_order if endpoints(L, edge)[0] == vertex]
        assert len(incoming) == len(outgoing)
        local_matrix = matrix(K8, [
            [K8(transition_entry(L, a, b, edge, successor))
             for successor in outgoing]
            for edge in incoming
        ])
        product_value *= local_matrix.det()
    return K8(row_sign * column_sign) * product_value


class_checks = ZZ(0)
zero_class_checks = ZZ(0)
nonzero_class_checks = ZZ(0)
local_type_distribution = {}
determinant_factorization_checks = ZZ(0)

for (doubled, single), fiber in sorted(all_fibers.items()):
    selectors = [
        selected for selected in base_edge_subsets
        if selected.issubset(single)
        and is_even_edge_subset(doubled.union(selected))
    ]
    inside = even_subgraphs_inside(single)
    character_is_trivial = all(character_value(single, item) == 1
                               for item in inside)
    if not selectors or not character_is_trivial:
        continue

    classes = {}
    for phi in fiber:
        orientation = induced_orientation(phi, single)
        orientation_key = tuple(sorted(orientation.items()))
        classes.setdefault(orientation_key, []).append(phi)

    for orientation_key, part in classes.items():
        orientation = dict(orientation_key)
        curved, straight = local_vertex_counts(single, orientation)
        local_type_distribution[(curved, straight)] = (
            local_type_distribution.get((curved, straight), ZZ(0)) + 1)
        for a in (0, 1):
            for b in (0, 1):
                part_sum = sum(
                    (contributions[permutation_key(phi)][(a, b)] for phi in part),
                    K8(0),
                )
                moved = moved_edges(part[0])
                local_product = local_determinant_product(moved, a, b)
                assert part_sum == K8((-1) ** len(moved)) * local_product
                determinant_factorization_checks += 1
                if curved > 0:
                    assert part_sum == K8(0)
                    zero_class_checks += 1
                else:
                    assert part_sum in ZZ
                    assert abs(ZZ(part_sum)) == ZZ(2) ** straight
                    nonzero_class_checks += 1
                class_checks += 1

assert class_checks == 4 * sum(local_type_distribution.values())
assert zero_class_checks > 0
assert nonzero_class_checks > 0
assert determinant_factorization_checks == class_checks
print("local type distribution %s" % sorted(local_type_distribution.items()))
print("PASS: L=%d の自明文字・選択非空ファイバーの均衡配向類 %d 件×"
      "四スピン構造を検査。曲がり型を持つ零和 %d 件、曲がり型を持たない"
      "局所積 2^(直進型頂点数) %d 件"
      % (L, sum(local_type_distribution.values()), zero_class_checks,
         nonzero_class_checks))
