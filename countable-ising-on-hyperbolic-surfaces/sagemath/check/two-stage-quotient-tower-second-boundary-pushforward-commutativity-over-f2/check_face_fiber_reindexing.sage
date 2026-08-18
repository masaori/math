# SageMath: 粗段面ごとのファイバー和を細段面全体の和へ添字付け替えする
# 対象ラベル: theorem_quotient_tower_second_boundary_pushforward_commutativity_over_f2
# 帰属: 有限剰余類面・辺セル集合と F_2 上の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_components = 0
for fine_coefficients in all_f2_coefficient_maps(fine_face_cells):
    for coarse_edge_cell in coarse_edge_cells:
        grouped_by_coarse_face = sum(
            (
                sum(
                    (
                        F2.one()
                        for position in face_positions(coarse_face_cell)
                        if coarse_boundary_edge(position) == coarse_edge_cell
                    ),
                    F2.zero(),
                )
                * sum(
                    (
                        fine_coefficients[fine_face_cell]
                        for fine_face_cell in fine_face_cells
                        if induced_face_cell(fine_face_cell) == coarse_face_cell
                    ),
                    F2.zero(),
                )
                for coarse_face_cell in coarse_face_cells
            ),
            F2.zero(),
        )
        reindexed_by_fine_face = sum(
            (
                sum(
                    (
                        F2.one()
                        for position in face_positions(
                            induced_face_cell(fine_face_cell)
                        )
                        if coarse_boundary_edge(position) == coarse_edge_cell
                    ),
                    F2.zero(),
                )
                * fine_coefficients[fine_face_cell]
                for fine_face_cell in fine_face_cells
            ),
            F2.zero(),
        )
        assert grouped_by_coarse_face == reindexed_by_fine_face
        checked_components += 1

assert checked_components == 2 ** len(fine_face_cells) * len(coarse_edge_cells)
print(
    "RESULT: PASS — grouping by coarse face fibers equals the reindexed "
    "sum over all fine faces"
)

