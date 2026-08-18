# SageMath: 粗段二次境界と面係数押し出しの合成を定義どおり展開する
# 対象ラベル: theorem_quotient_tower_second_boundary_pushforward_commutativity_over_f2
# 帰属: 有限剰余類面・辺セル集合と F_2 上の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_components = 0
for fine_coefficients in all_f2_coefficient_maps(fine_face_cells):
    left_side = coarse_second_boundary(
        face_coefficient_pushforward(fine_coefficients)
    )
    for coarse_edge_cell in coarse_edge_cells:
        expanded = sum(
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
        assert left_side[coarse_edge_cell] == expanded
        checked_components += 1

assert checked_components == 2 ** len(fine_face_cells) * len(coarse_edge_cells)
print(
    "RESULT: PASS — the coarse second boundary after face pushforward "
    "equals its finite incidence-sum expansion"
)

