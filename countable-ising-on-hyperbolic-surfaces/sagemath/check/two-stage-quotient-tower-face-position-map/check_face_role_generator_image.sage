# SageMath: 面役割生成元の段間整合性の検算
# 対象ラベル: def_quotient_tower_induced_face_position_map
# 式: kappa(r_F^fine) = r_F^coarse
# 帰属: 有限商群だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

assert stage_map(fine_roles["face"]) == coarse_roles["face"]

for fine_face_cell in fine_face_cells:
    for element in fine_face_cell:
        left = quotient_product(
            stage_map(element),
            stage_map(fine_roles["face"]),
            coarse_kernel,
            COARSE,
        )
        right = quotient_product(
            stage_map(element),
            coarse_roles["face"],
            coarse_kernel,
            COARSE,
        )
        assert left == right

print(
    "RESULT: PASS — the fine face-role generator maps to the coarse "
    "face-role generator in every successor product"
)
