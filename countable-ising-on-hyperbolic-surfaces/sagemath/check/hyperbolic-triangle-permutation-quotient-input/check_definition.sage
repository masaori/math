# SageMath: 双曲三角群の有限置換商入力の厳密検算
# 対象ラベル: def_hyperbolic_triangle_permutation_quotient_input

ambient = SymmetricGroup(8)

face_rotation = ambient("(1,6,2)(3,8,4)")
vertex_rotation = ambient("(1,8,4,2,5,6,7)")
edge_half_turn = ambient("(1,4)(2,5)(3,8)(6,7)")

quotient_group = PermutationGroup(
    [face_rotation, vertex_rotation, edge_half_turn],
    canonicalize=False,
)

p = ZZ(3)
q = ZZ(7)

assert quotient_group.is_finite()
assert quotient_group.order() == 168
assert face_rotation in quotient_group
assert vertex_rotation in quotient_group
assert edge_half_turn in quotient_group
assert face_rotation.order() == p
assert vertex_rotation.order() == q
assert edge_half_turn.order() == 2
for point in range(1, 9):
    assert face_rotation(vertex_rotation(edge_half_turn(point))) == point
assert quotient_group.is_transitive()
assert QQ(1) / p + QQ(1) / q < QQ(1) / 2

print(
    "RESULT: PASS — the explicit degree-eight permutations satisfy the finite "
    "hyperbolic triangle quotient input conditions exactly"
)
