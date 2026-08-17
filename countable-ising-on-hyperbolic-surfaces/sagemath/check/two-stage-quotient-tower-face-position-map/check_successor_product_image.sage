# SageMath: 次位置を作る積が段間群準同型で積へ移ることの検算
# 対象ラベル: def_quotient_tower_induced_face_position_map
# 式: kappa(a r_F^fine) = kappa(a) kappa(r_F^fine)
# 帰属: 有限商群だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for fine_face_cell in fine_face_cells:
    for element in fine_face_cell:
        fine_product = quotient_product(
            element,
            fine_roles["face"],
            fine_kernel,
            FINE,
        )
        image_product = quotient_product(
            stage_map(element),
            stage_map(fine_roles["face"]),
            coarse_kernel,
            COARSE,
        )
        assert stage_map(fine_product) == image_product

print(
    "RESULT: PASS — the image of every fine successor product equals "
    "the product of the two coarse images"
)
