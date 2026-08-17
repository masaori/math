# SageMath: 誘導位置写像と次位置写像の可換性の検算
# 対象ラベル: def_quotient_tower_induced_face_position_map
# 式: kappa_P(s_fine(position)) = s_coarse(kappa_P(position))
# 帰属: 有限商群と有限剰余類集合だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_positions = 0
for fine_face_cell in fine_face_cells:
    for fine_position in face_positions(fine_face_cell):
        left = induced_position_image(fine_successor(fine_position))
        right = coarse_successor(induced_position_image(fine_position))
        assert left == right
        checked_positions += 1

assert checked_positions == sum(len(face) for face in fine_face_cells)
print(
    "RESULT: PASS — the induced face-position map commutes with the "
    "successor maps at every fine face position"
)
