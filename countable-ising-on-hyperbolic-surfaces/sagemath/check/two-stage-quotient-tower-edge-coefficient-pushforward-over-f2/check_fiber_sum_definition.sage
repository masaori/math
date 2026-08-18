# SageMath: F_2 辺係数押し出し写像の有限ファイバー和定義の検算
# 対象ラベル: def_quotient_tower_edge_coefficient_pushforward_over_f2
# 式ペア: (bar(kappa)_{E,!} c)(D_E) = sum_{bar(kappa)_E(C_E)=D_E} c(C_E)
# 帰属: 有限剰余類辺セル集合と F_2 上の厳密有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_coefficient_maps = 0
checked_components = 0

for fine_coefficients in all_f2_coefficient_maps(fine_edge_cells):
    pushed_coefficients = edge_coefficient_pushforward(fine_coefficients)
    assert set(pushed_coefficients) == set(coarse_edge_cells)
    for coarse_edge_cell in coarse_edge_cells:
        fiber = tuple(
            fine_edge_cell
            for fine_edge_cell in fine_edge_cells
            if induced_labeled_edge_cell(fine_edge_cell) == coarse_edge_cell
        )
        assert fiber
        expected_coefficient = sum(
            (fine_coefficients[fine_edge_cell] for fine_edge_cell in fiber),
            F2.zero(),
        )
        assert pushed_coefficients[coarse_edge_cell] == expected_coefficient
        checked_components += 1
    checked_coefficient_maps += 1

assert checked_coefficient_maps == 2 ** len(fine_edge_cells)
assert checked_components == checked_coefficient_maps * len(coarse_edge_cells)

print(
    "RESULT: PASS — every coarse edge coefficient equals the exact F_2 sum "
    "over its finite induced-edge fiber for every fine edge coefficient map"
)
