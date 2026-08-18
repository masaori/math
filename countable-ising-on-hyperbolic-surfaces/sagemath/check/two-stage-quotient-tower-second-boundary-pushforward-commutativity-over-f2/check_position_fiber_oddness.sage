# SageMath: 誘導面位置写像の各ファイバーが奇数元であることを検算する
# 対象ラベル: theorem_quotient_tower_second_boundary_pushforward_commutativity_over_f2
# 式ペア: sum_{i: kappa_P(i)=j} 1_F2 = 1_F2
# 帰属: 有限境界位置集合と F_2 上の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_fibers = 0
for fine_face_cell in fine_face_cells:
    coarse_face_cell = induced_face_cell(fine_face_cell)
    for coarse_position in face_positions(coarse_face_cell):
        fiber = position_fiber(fine_face_cell, coarse_position)
        assert len(fiber) == 3
        assert sum((F2.one() for _ in fiber), F2.zero()) == F2.one()
        checked_fibers += 1

assert checked_fibers == sum(
    len(face_positions(induced_face_cell(fine_face_cell)))
    for fine_face_cell in fine_face_cells
)

print(
    "RESULT: PASS — every induced face-position fiber has three elements "
    "and therefore odd F_2 cardinality"
)

