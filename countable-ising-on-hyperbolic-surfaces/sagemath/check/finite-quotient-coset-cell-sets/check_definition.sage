# SageMath: 役割安定化部分群と剰余類セル集合の厳密検算
# 対象ラベル: def_finite_quotient_role_stabilizers_and_coset_cell_sets
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

assert face_stabilizer.order() == 3
assert vertex_stabilizer.order() == 7
assert edge_stabilizer.order() == 2

face_cosets = list(quotient_group.cosets(face_stabilizer, side="left"))
vertex_cosets = list(quotient_group.cosets(vertex_stabilizer, side="left"))
edge_cosets = list(quotient_group.cosets(edge_stabilizer, side="left"))

assert len(face_cosets) == 56
assert len(vertex_cosets) == 24
assert len(edge_cosets) == 84

for subgroup, cosets in (
    (face_stabilizer, face_cosets),
    (vertex_stabilizer, vertex_cosets),
    (edge_stabilizer, edge_cosets),
):
    flattened = [element for coset in cosets for element in coset]
    assert len(flattened) == quotient_group.order()
    assert len(set(flattened)) == quotient_group.order()
    assert set(flattened) == set(quotient_group)
    for coset in cosets:
        representative = coset[0]
        expected_coset = {representative * element for element in subgroup}
        assert set(coset) == expected_coset
        for element in subgroup:
            changed_representative = representative * element
            changed_coset = {changed_representative * member for member in subgroup}
            assert changed_coset == expected_coset

face_cells = {("face", frozenset(coset)) for coset in face_cosets}
vertex_cells = {("vertex", frozenset(coset)) for coset in vertex_cosets}
edge_cells = {("edge", frozenset(coset)) for coset in edge_cosets}

assert face_cells.isdisjoint(vertex_cells)
assert face_cells.isdisjoint(edge_cells)
assert vertex_cells.isdisjoint(edge_cells)

print(
    "RESULT: PASS — the cyclic role subgroups and their left cosets partition "
    "the order-168 group, are representative-independent, and yield disjoint "
    "tagged cell-label sets"
)
