# SageMath: 面境界の押し出しを与える粗段面係数 witness の厳密検算
# 対象ラベル: theorem_quotient_tower_face_boundary_space_pushforward_over_f2

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for fine_face_coefficients in all_f2_coefficient_maps(fine_face_cells):
    fine_boundary = fine_second_boundary(fine_face_coefficients)
    pushed_boundary = edge_coefficient_pushforward(fine_boundary)
    coarse_witness = face_coefficient_pushforward(fine_face_coefficients)
    witnessed_boundary = coarse_second_boundary(coarse_witness)
    assert pushed_boundary == witnessed_boundary

print(
    "RESULT: PASS — face-coefficient pushforward gives a coarse face "
    "coefficient witness for every pushed fine face boundary"
)
