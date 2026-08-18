# SageMath: F_2 頂点係数押し出し写像の有限ファイバー和定義の検算
# 対象ラベル: def_quotient_tower_vertex_coefficient_pushforward_over_f2
# 式ペア: (bar(kappa)_{V,!} b)(D_V) = sum_{bar(kappa)_V(C_V)=D_V} b(C_V)
# 帰属: 有限剰余類頂点セル集合と F_2 上の厳密有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_coefficient_maps = 0
checked_components = 0

for fine_coefficients in all_f2_coefficient_maps(fine_vertex_cells):
    pushed_coefficients = vertex_coefficient_pushforward(fine_coefficients)
    assert set(pushed_coefficients) == set(coarse_vertex_cells)
    for coarse_vertex_cell in coarse_vertex_cells:
        fiber = tuple(
            fine_vertex_cell
            for fine_vertex_cell in fine_vertex_cells
            if induced_labeled_vertex_cell(fine_vertex_cell) == coarse_vertex_cell
        )
        assert fiber
        expected_coefficient = sum(
            (fine_coefficients[fine_vertex_cell] for fine_vertex_cell in fiber),
            F2.zero(),
        )
        assert pushed_coefficients[coarse_vertex_cell] == expected_coefficient
        checked_components += 1
    checked_coefficient_maps += 1

assert checked_coefficient_maps == 2 ** len(fine_vertex_cells)
assert checked_components == checked_coefficient_maps * len(coarse_vertex_cells)

print(
    "RESULT: PASS — every coarse vertex coefficient equals the exact F_2 sum "
    "over its finite induced-vertex fiber for every fine vertex coefficient map"
)
