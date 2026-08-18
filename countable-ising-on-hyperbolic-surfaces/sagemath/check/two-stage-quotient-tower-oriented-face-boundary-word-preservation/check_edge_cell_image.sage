# SageMath: 面位置に置かれた辺セル成分の像の検算
# 対象ラベル: theorem_quotient_tower_oriented_face_boundary_word_preservation
# 式: kappa_E(a H_E^fine) = kappa(a) H_E^coarse
# 帰属: 有限商群と有限剰余類集合だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_positions = 0
for fine_face_cell in fine_face_cells:
    for fine_position in face_positions(fine_face_cell):
        _, fine_element = fine_position
        fine_edge_cell = fine_edge_cell_at(fine_element)
        coarse_edge_cell = coarse_edge_cell_at(stage_map(fine_element))
        assert induced_cell_image("edge", fine_edge_cell) == coarse_edge_cell
        checked_positions += 1

assert checked_positions == sum(len(face) for face in fine_face_cells)
print(
    "RESULT: PASS — every edge cell placed at a fine face position maps "
    "to the edge cell placed at the induced coarse face position"
)
