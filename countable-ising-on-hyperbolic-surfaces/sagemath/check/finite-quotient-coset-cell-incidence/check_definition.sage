# SageMath: 剰余類セル間の incidence 関係の厳密検算
# 対象ラベル: def_finite_quotient_coset_cell_incidence_relation
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


def coset_incident(left_coset, right_coset):
    return not left_coset.isdisjoint(right_coset)


def representatives_witness_incidence(left_representative, left_subgroup, right_representative, right_subgroup):
    return any(
        left_representative * left_member == right_representative * right_member
        for left_member in left_subgroup
        for right_member in right_subgroup
    )


for left_cosets, left_subgroup, right_cosets, right_subgroup in (
    (face_cosets, face_stabilizer, vertex_cosets, vertex_stabilizer),
    (face_cosets, face_stabilizer, edge_cosets, edge_stabilizer),
    (vertex_cosets, vertex_stabilizer, edge_cosets, edge_stabilizer),
):
    for left_coset in left_cosets:
        for right_coset in right_cosets:
            expected = coset_incident(left_coset, right_coset)
            for left_representative in left_coset:
                for right_representative in right_coset:
                    assert representatives_witness_incidence(
                        left_representative,
                        left_subgroup,
                        right_representative,
                        right_subgroup,
                    ) == expected

face_vertex_incidence = {
    (face_coset, vertex_coset)
    for face_coset in face_cosets
    for vertex_coset in vertex_cosets
    if coset_incident(face_coset, vertex_coset)
}
face_edge_incidence = {
    (face_coset, edge_coset)
    for face_coset in face_cosets
    for edge_coset in edge_cosets
    if coset_incident(face_coset, edge_coset)
}
vertex_edge_incidence = {
    (vertex_coset, edge_coset)
    for vertex_coset in vertex_cosets
    for edge_coset in edge_cosets
    if coset_incident(vertex_coset, edge_coset)
}

assert len(face_vertex_incidence) == 168
assert len(face_edge_incidence) == 168
assert len(vertex_edge_incidence) == 168

assert {sum(face == pair[0] for pair in face_vertex_incidence) for face in face_cosets} == {3}
assert {sum(vertex == pair[1] for pair in face_vertex_incidence) for vertex in vertex_cosets} == {7}
assert {sum(face == pair[0] for pair in face_edge_incidence) for face in face_cosets} == {3}
assert {sum(edge == pair[1] for pair in face_edge_incidence) for edge in edge_cosets} == {2}
assert {sum(vertex == pair[0] for pair in vertex_edge_incidence) for vertex in vertex_cosets} == {7}
assert {sum(edge == pair[1] for pair in vertex_edge_incidence) for edge in edge_cosets} == {2}

assert len(face_vertex_incidence) < len(face_cosets) * len(vertex_cosets)
assert len(face_edge_incidence) < len(face_cosets) * len(edge_cosets)
assert len(vertex_edge_incidence) < len(vertex_cosets) * len(edge_cosets)

print(
    "RESULT: PASS — coset intersection defines representative-independent "
    "face-vertex, face-edge, and vertex-edge incidence relations with exact "
    "degree counts for the order-168 finite quotient"
)
