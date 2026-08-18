# SageMath: 奇数位置ファイバーと境界語保存から面ごとの辺 incidence が一致することを検算する
# 対象ラベル: theorem_quotient_tower_second_boundary_pushforward_commutativity_over_f2
# 帰属: 有限境界位置集合、有限剰余類辺セル集合、F_2 上の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_pairs = 0
for fine_face_cell in fine_face_cells:
    coarse_face_cell = induced_face_cell(fine_face_cell)
    for coarse_edge_cell in coarse_edge_cells:
        coarse_incidence = sum(
            (
                F2.one()
                for coarse_position in face_positions(coarse_face_cell)
                if coarse_boundary_edge(coarse_position) == coarse_edge_cell
            ),
            F2.zero(),
        )
        fine_image_incidence = sum(
            (
                F2.one()
                for fine_position in face_positions(fine_face_cell)
                if induced_edge_cell(fine_boundary_edge(fine_position))
                == coarse_edge_cell
            ),
            F2.zero(),
        )
        assert coarse_incidence == fine_image_incidence
        checked_pairs += 1

assert checked_pairs == len(fine_face_cells) * len(coarse_edge_cells)
print(
    "RESULT: PASS — odd position fibers and preserved boundary edge "
    "components give identical F_2 face-edge incidence"
)

