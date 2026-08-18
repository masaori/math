# SageMath: F_2 面係数押し出し写像の有限ファイバー和定義の検算
# 対象ラベル: def_quotient_tower_face_coefficient_pushforward_over_f2
# 式ペア: (bar(kappa)_{F,!} a)(D_F) = sum_{bar(kappa)_F(C_F)=D_F} a(C_F)
# 帰属: 有限剰余類面セル集合と F_2 上の厳密有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_coefficient_maps = 0
checked_components = 0

for fine_coefficients in all_f2_coefficient_maps(fine_face_cells):
    pushed_coefficients = face_coefficient_pushforward(fine_coefficients)
    assert set(pushed_coefficients) == set(coarse_face_cells)
    for coarse_face_cell in coarse_face_cells:
        fiber = tuple(
            fine_face_cell
            for fine_face_cell in fine_face_cells
            if induced_labeled_face_cell(fine_face_cell) == coarse_face_cell
        )
        assert fiber
        expected_coefficient = sum(
            (fine_coefficients[fine_face_cell] for fine_face_cell in fiber),
            F2.zero(),
        )
        assert pushed_coefficients[coarse_face_cell] == expected_coefficient
        checked_components += 1
    checked_coefficient_maps += 1

assert checked_coefficient_maps == 2 ** len(fine_face_cells)
assert checked_components == checked_coefficient_maps * len(coarse_face_cells)

print(
    "RESULT: PASS — every coarse face coefficient equals the exact F_2 sum "
    "over its finite induced-face fiber for every fine face coefficient map"
)
