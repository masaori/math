# SageMath: 誘導位置写像の像が対応する粗段面位置集合に属することの検算
# 対象ラベル: def_quotient_tower_induced_face_position_map
# 式: a in C_F implies kappa(a) in D_F
# 帰属: 有限商群と有限剰余類集合だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_positions = 0
for fine_face_cell in fine_face_cells:
    coarse_face_cell = induced_cell_image("face", fine_face_cell)
    assert coarse_face_cell in coarse_face_cells
    coarse_positions = face_positions(coarse_face_cell)
    for fine_position in face_positions(fine_face_cell):
        assert induced_position_image(fine_position) in coarse_positions
        checked_positions += 1

assert checked_positions == sum(len(face) for face in fine_face_cells)
print(
    "RESULT: PASS — every fine face position maps into the position set "
    "of its induced coarse face"
)
