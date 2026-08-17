# SageMath: 剰余類面の巡回位置系の厳密検算
# 対象ラベル: def_finite_quotient_face_cyclic_position_system
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
face_cosets = [frozenset(coset) for coset in quotient_group.cosets(face_stabilizer, side="left")]


def successor(position):
    position_label, group_element = position
    return (position_label, group_element * face_rotation)


def predecessor(position):
    position_label, group_element = position
    return (position_label, group_element * face_rotation ** 2)


for face_coset in face_cosets:
    positions = {("position", group_element) for group_element in face_coset}

    assert len(positions) == face_rotation.order() == 3
    assert {successor(position) for position in positions} == positions
    assert {predecessor(position) for position in positions} == positions

    for position in positions:
        assert predecessor(successor(position)) == position
        assert successor(predecessor(position)) == position

        orbit = {position}
        current = position
        for _ in range(1, face_rotation.order()):
            current = successor(current)
            orbit.add(current)
        assert orbit == positions
        assert successor(current) == position

assert len(face_cosets) == 56

print(
    "RESULT: PASS — right multiplication by the face rotation defines one "
    "three-position cycle on every one of the 56 face cosets"
)
