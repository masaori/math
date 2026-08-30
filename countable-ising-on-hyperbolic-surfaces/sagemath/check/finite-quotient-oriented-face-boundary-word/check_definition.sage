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

def left_coset(group_element, subgroup):
    # 本文の積 (gk)(alpha)=g(k(alpha)) は Sage の積順序と逆である。
    return frozenset(member * group_element for member in subgroup)


def all_left_cosets(subgroup):
    return list({left_coset(group_element, subgroup) for group_element in quotient_group})


face_cosets = all_left_cosets(face_stabilizer)
vertex_cosets = all_left_cosets(vertex_stabilizer)
edge_cosets = all_left_cosets(edge_stabilizer)


def permutation_key(permutation):
    return tuple(permutation(index) for index in range(1, 9))


def representative_selector(edge_coset):
    return min(edge_coset, key=permutation_key)


def boundary_entry(group_element):
    edge_coset = left_coset(group_element, edge_stabilizer)
    selected = representative_selector(edge_coset)
    if selected == group_element:
        orientation = "forward"
    else:
        assert selected == edge_half_turn * group_element
        orientation = "reverse"
    return edge_coset, orientation


def traversal_endpoints(group_element, edge_coset, orientation):
    selected = representative_selector(edge_coset)
    source = left_coset(selected, vertex_stabilizer)
    target = left_coset(edge_half_turn * selected, vertex_stabilizer)
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
        assert start_vertex == left_coset(group_element, vertex_stabilizer)
        assert end_vertex == left_coset(edge_half_turn * group_element, vertex_stabilizer)
        assert start_vertex in vertex_cosets
        assert end_vertex in vertex_cosets

        next_group_element = face_rotation * group_element
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
