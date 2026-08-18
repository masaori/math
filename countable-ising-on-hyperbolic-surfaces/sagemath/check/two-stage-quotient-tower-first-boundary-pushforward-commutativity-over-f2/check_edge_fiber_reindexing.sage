# SageMath: 粗段辺ファイバーによる有限和の添字付け替えを検算する
# 対象ラベル: theorem_quotient_tower_first_boundary_pushforward_commutativity_over_f2
# 式ペア: sum_{D_E} incidence_coarse(D_V,D_E) sum_{bar(kappa)_E(C_E)=D_E} c(C_E)
#          = sum_{C_E} incidence_coarse(D_V,bar(kappa)_E(C_E)) c(C_E)
# 帰属: 有限剰余類頂点・辺セル集合と F_2 上の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for fine_coefficients in all_f2_coefficient_maps(fine_edge_cells):
    for coarse_vertex_cell in coarse_vertex_cells:
        left_side = sum(
            (
                coarse_boundary_coefficient(coarse_vertex_cell, coarse_edge_cell)
                * sum(
                    (
                        fine_coefficients[fine_edge_cell]
                        for fine_edge_cell in fine_edge_cells
                        if induced_edge_cell(fine_edge_cell) == coarse_edge_cell
                    ),
                    F2.zero(),
                )
                for coarse_edge_cell in coarse_edge_cells
            ),
            F2.zero(),
        )
        right_side = sum(
            (
                coarse_boundary_coefficient(
                    coarse_vertex_cell,
                    induced_edge_cell(fine_edge_cell),
                )
                * fine_coefficients[fine_edge_cell]
                for fine_edge_cell in fine_edge_cells
            ),
            F2.zero(),
        )
        assert left_side == right_side

print(
    "RESULT: PASS — every coarse-vertex component is unchanged when the "
    "finite sum is reindexed from coarse-edge fibers to fine edges"
)
