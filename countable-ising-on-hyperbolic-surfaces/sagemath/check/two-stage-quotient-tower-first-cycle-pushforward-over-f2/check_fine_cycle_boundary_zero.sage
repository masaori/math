# SageMath: 細段一次サイクルの境界が零である等式を押し出し後も照合する
# 対象ラベル: theorem_quotient_tower_first_cycle_pushforward_over_f2
# 式ペア: bar(kappa)_{V,!}(partial_1_fine(c))
#          = bar(kappa)_{V,!}(0)
# 帰属: 有限剰余類頂点・辺セル集合と F_2 上の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

zero_fine_vertex_coefficients = {
    fine_vertex_cell: F2.zero()
    for fine_vertex_cell in fine_vertex_cells
}

for fine_cycle in fine_first_cycles:
    fine_boundary = fine_first_boundary(fine_cycle)
    assert fine_boundary == zero_fine_vertex_coefficients
    left_side = vertex_coefficient_pushforward(fine_boundary)
    right_side = vertex_coefficient_pushforward(zero_fine_vertex_coefficients)
    assert left_side == right_side

print(
    "RESULT: PASS — pushing forward the fine boundary of every fine first "
    "cycle equals pushing forward the zero vertex coefficient map"
)

