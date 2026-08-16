# SageMath: 面境界空間が一次サイクル空間に含まれることの厳密検算
# 対象ラベル: def_face_boundary_space_over_f2
# 併せて検証: theorem_boundary_of_boundary_is_zero_over_f2, def_first_cycle_space_over_f2
# 式ペア: partial_1(partial_2 b) = (partial_1 partial_2)b = 0
# 帰属: 形式的な有限ラベル集合と GF(2) 上の有限行列だけを用いる。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

face_boundary_space = {
    tuple(second_boundary * face_coefficients)
    for face_coefficients in face_coefficient_space
}
first_cycle_space = {
    tuple(edge_coefficients)
    for edge_coefficients in edge_coefficient_space
    if first_boundary * edge_coefficients == zero_vertex_coefficients
}

assert first_boundary * second_boundary == zero_matrix(GF(2), len(vertices), len(faces))

for face_coefficients in face_coefficient_space:
    direct_composite = first_boundary * (second_boundary * face_coefficients)
    matrix_composite = (first_boundary * second_boundary) * face_coefficients
    assert direct_composite == matrix_composite
    assert matrix_composite == zero_vertex_coefficients

assert face_boundary_space.issubset(first_cycle_space)

print("RESULT: PASS — every finite GF(2) face boundary lies in the first-cycle space")
