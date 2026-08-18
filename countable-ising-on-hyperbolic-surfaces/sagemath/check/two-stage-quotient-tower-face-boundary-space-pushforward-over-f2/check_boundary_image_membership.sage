# SageMath: 全細段面境界の押し出しが粗段面境界空間へ入ることの厳密検算
# 対象ラベル: theorem_quotient_tower_face_boundary_space_pushforward_over_f2

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

coarse_boundary_set = set(coarse_face_boundaries)

for fine_boundary_values in fine_face_boundaries:
    fine_boundary = tuple_to_coefficient_map(
        fine_boundary_values,
        fine_edge_cells,
    )
    pushed_boundary = edge_coefficient_pushforward(fine_boundary)
    pushed_boundary_values = coefficient_tuple(
        pushed_boundary,
        coarse_edge_cells,
    )
    assert pushed_boundary_values in coarse_boundary_set

print(
    "RESULT: PASS — every fine face boundary is sent by edge-coefficient "
    "pushforward into the coarse face-boundary space"
)
