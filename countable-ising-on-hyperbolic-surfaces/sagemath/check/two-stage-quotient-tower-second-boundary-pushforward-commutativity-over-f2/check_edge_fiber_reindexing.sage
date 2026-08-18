# SageMath: 細段面位置の和を誘導辺セル写像のファイバーごとにまとめ直す
# 対象ラベル: theorem_quotient_tower_second_boundary_pushforward_commutativity_over_f2
# 帰属: 有限剰余類面・辺セル集合、有限境界位置集合、F_2 上の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_components = 0
for fine_coefficients in all_f2_coefficient_maps(fine_face_cells):
    for coarse_edge_cell in coarse_edge_cells:
        image_incidence_sum = sum(
            (
                sum(
                    (
                        F2.one()
                        for fine_position in face_positions(fine_face_cell)
                        if induced_edge_cell(fine_boundary_edge(fine_position))
                        == coarse_edge_cell
                    ),
                    F2.zero(),
                )
                * fine_coefficients[fine_face_cell]
                for fine_face_cell in fine_face_cells
            ),
            F2.zero(),
        )
        grouped_by_fine_edge = sum(
            (
                sum(
                    (
                        sum(
                            (
                                F2.one()
                                for fine_position in face_positions(fine_face_cell)
                                if fine_boundary_edge(fine_position) == fine_edge_cell
                            ),
                            F2.zero(),
                        )
                        * fine_coefficients[fine_face_cell]
                        for fine_face_cell in fine_face_cells
                    ),
                    F2.zero(),
                )
                for fine_edge_cell in fine_edge_cells
                if induced_edge_cell(fine_edge_cell) == coarse_edge_cell
            ),
            F2.zero(),
        )
        assert image_incidence_sum == grouped_by_fine_edge
        checked_components += 1

assert checked_components == 2 ** len(fine_face_cells) * len(coarse_edge_cells)
print(
    "RESULT: PASS — the fine-position sum equals the sum grouped by "
    "fibers of the induced edge-cell map"
)

