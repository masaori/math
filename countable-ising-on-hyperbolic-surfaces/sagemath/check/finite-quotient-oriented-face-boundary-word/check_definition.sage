# SageMath: 剰余類面の向き付き境界語の厳密検算
# 対象ラベル: def_finite_quotient_oriented_coset_face_boundary_word
# 帰属: 有限置換群と有限集合だけを用いる

ambient = SymmetricGroup(8)

face_rotation = ambient("(1,6,2)(3,8,4)")
vertex_rotation = ambient("(1,8,4,2,5,6,7)")
edge_half_turn = ambient("(1,4)(2,5)(3,8)(6,7)")

quotient_group = PermutationGroup(
    [face_rotation, vertex_rotation, edge_half_turn],
    canonicalize=False,
)

face_stabilizer = quotient_group.subgroup([face_rotation])
vertex_stabilizer = quotient_group.subgroup([vertex_rotation])
edge_stabilizer = quotient_group.subgroup([edge_half_turn])

face_cosets = [frozenset(coset) for coset in quotient_group.cosets(face_stabilizer, side="left")]
vertex_cosets = [frozenset(coset) for coset in quotient_group.cosets(vertex_stabilizer, side="left")]
edge_cosets = [frozenset(coset) for coset in quotient_group.cosets(edge_stabilizer, side="left")]


def permutation_key(permutation):
    return tuple(permutation(index) for index in range(1, 9))


def representative_selector(edge_coset):
    return min(edge_coset, key=permutation_key)


def left_coset(group_element, subgroup):
    return frozenset(group_element * member for member in subgroup)


def boundary_entry(group_element):
    edge_coset = left_coset(group_element, edge_stabilizer)
    selected = representative_selector(edge_coset)
    if selected == group_element:
        orientation = "reverse"
    else:
        assert selected == group_element * edge_half_turn
        orientation = "forward"
    return edge_coset, orientation


def traversal_endpoints(group_element, edge_coset, orientation):
    selected = representative_selector(edge_coset)
    source = left_coset(selected, vertex_stabilizer)
    target = left_coset(selected * edge_half_turn, vertex_stabilizer)
    if orientation == "forward":
        return source, target
    assert orientation == "reverse"
    return target, source


occurrences = []

for face_coset in face_cosets:
    positions = {("position", group_element) for group_element in face_coset}
    assert len(positions) == face_rotation.order() == 3

    for position_label, group_element in positions:
        edge_coset, orientation = boundary_entry(group_element)
        assert edge_coset in edge_cosets

        start_vertex, end_vertex = traversal_endpoints(group_element, edge_coset, orientation)
        assert start_vertex == left_coset(group_element * edge_half_turn, vertex_stabilizer)
        assert end_vertex == left_coset(group_element, vertex_stabilizer)
        assert start_vertex in vertex_cosets
        assert end_vertex in vertex_cosets

        next_group_element = group_element * face_rotation
        next_edge_coset, next_orientation = boundary_entry(next_group_element)
        next_start_vertex, _ = traversal_endpoints(
            next_group_element,
            next_edge_coset,
            next_orientation,
        )
        assert end_vertex == next_start_vertex

        occurrences.append((edge_coset, orientation))

assert len(face_cosets) == 56
assert len(edge_cosets) == 84
assert len(occurrences) == 168
assert len(set(occurrences)) == 168
assert sum(orientation == "forward" for _, orientation in occurrences) == 84
assert sum(orientation == "reverse" for _, orientation in occurrences) == 84

print(
    "RESULT: PASS — all 56 quotient faces have one connected three-edge "
    "oriented boundary word; the 168 positions realize every quotient edge "
    "once in each formal orientation"
)
