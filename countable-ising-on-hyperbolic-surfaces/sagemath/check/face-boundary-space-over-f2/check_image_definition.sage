# SageMath: 二次境界写像の像による面境界空間の定義
# 対象ラベル: def_face_boundary_space_over_f2
# 対象: homology-sector-expansion.ts の「F_2 上の面境界空間」
# 式ペア: Boundary_1 = im(partial_2) = {partial_2 b | b in F_2^F}
# 帰属: 形式的な有限ラベル集合と GF(2) 上の有限行列だけを用いる。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

image_from_definition = {
    tuple(second_boundary * face_coefficients)
    for face_coefficients in face_coefficient_space
}
image_from_column_space = {
    tuple(edge_coefficients)
    for edge_coefficients in second_boundary.column_space()
}

expected_boundary_space = {
    (GF(2).zero(), GF(2).zero(), GF(2).zero()),
    (GF(2).one(), GF(2).one(), GF(2).one()),
}

assert image_from_definition == image_from_column_space
assert image_from_definition == expected_boundary_space

print("RESULT: PASS — the face-boundary space is exactly the image of the finite GF(2) second-boundary matrix")
