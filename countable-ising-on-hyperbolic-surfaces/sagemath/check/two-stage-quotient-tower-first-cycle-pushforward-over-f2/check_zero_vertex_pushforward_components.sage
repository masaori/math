# SageMath: 零頂点係数写像の押し出しを各粗段頂点ファイバーで検算する
# 対象ラベル: theorem_quotient_tower_first_cycle_pushforward_over_f2
# 式ペア: (bar(kappa)_{V,!}(0))(D_V)
#          = sum_{bar(kappa)_V(C_V)=D_V} 0 = 0
# 帰属: 有限剰余類頂点セル集合と F_2 上の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

zero_fine_vertex_coefficients = {
    fine_vertex_cell: F2.zero()
    for fine_vertex_cell in fine_vertex_cells
}
pushed_zero = vertex_coefficient_pushforward(zero_fine_vertex_coefficients)

for coarse_vertex_cell in coarse_vertex_cells:
    fiber_sum = sum(
        (
            F2.zero()
            for fine_vertex_cell in fine_vertex_cells
            if induced_vertex_cell(fine_vertex_cell) == coarse_vertex_cell
        ),
        F2.zero(),
    )
    assert pushed_zero[coarse_vertex_cell] == fiber_sum
    assert fiber_sum == F2.zero()

print(
    "RESULT: PASS — every component of the pushed-forward zero vertex "
    "coefficient map is the finite sum of zeros and equals zero"
)

