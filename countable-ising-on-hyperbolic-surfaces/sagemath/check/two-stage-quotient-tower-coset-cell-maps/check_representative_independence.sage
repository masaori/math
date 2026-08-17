# SageMath: 誘導セル写像の代表元非依存性を検証する
# 対象ラベル: def_quotient_tower_induced_coset_cell_maps
# 式ペア: g H_R^fine = h H_R^fine => kappa(g) H_R^coarse = kappa(h) H_R^coarse
# 帰属: 有限商群と有限剰余類集合だけを用いる。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for role in source_roles:
    for fine_element in fine_quotient:
        fine_cell_coset = quotient_left_coset(
            fine_element,
            fine_stabilizers[role],
            fine_kernel,
            FINE,
        )
        coarse_images = {
            quotient_left_coset(
                stage_map(representative),
                coarse_stabilizers[role],
                coarse_kernel,
                COARSE,
            )
            for representative in fine_cell_coset
        }
        assert len(coarse_images) == 1

print(
    "RESULT: PASS — every representative of every fine face, vertex, "
    "and edge coset cell has the same coarse cell image"
)
