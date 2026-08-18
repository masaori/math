# SageMath: 向き付き面境界語全体の段間保存の検算
# 対象ラベル: theorem_quotient_tower_oriented_face_boundary_word_preservation
# 式: (kappa_E x id_Ori)(partial_word^fine(position)) = partial_word^coarse(kappa_P(position))
# 帰属: 有限商群、有限剰余類集合、形式的向きラベルだけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_positions = 0
for fine_face_cell in fine_face_cells:
    coarse_face_cell = induced_cell_image("face", fine_face_cell)
    assert coarse_face_cell in coarse_face_cells
    for fine_position in face_positions(fine_face_cell):
        coarse_position = induced_position_image(fine_position)
        assert coarse_position in face_positions(coarse_face_cell)
        left = induced_boundary_entry(fine_boundary_entry(fine_position))
        right = coarse_boundary_entry(coarse_position)
        assert left == right
        checked_positions += 1

assert checked_positions == sum(len(face) for face in fine_face_cells)
print(
    "RESULT: PASS — every oriented boundary entry of every fine face "
    "equals the oriented boundary entry at its induced coarse face position"
)
