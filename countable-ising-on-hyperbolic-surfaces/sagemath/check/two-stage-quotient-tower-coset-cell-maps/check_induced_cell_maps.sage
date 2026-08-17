# SageMath: 面・頂点・辺の誘導剰余類セル写像を検証する
# 対象ラベル: def_quotient_tower_induced_coset_cell_maps
# 式ペア: bar(kappa)_R(fine, R, g H_R^fine) = (coarse, R, kappa(g) H_R^coarse)
# 帰属: 三つの形式的役割ラベルと有限剰余類集合だけを用いる。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for role in source_roles:
    fine_cells = {
        (FINE, role, quotient_left_coset(
            element,
            fine_stabilizers[role],
            fine_kernel,
            FINE,
        ))
        for element in fine_quotient
    }
    coarse_cells = {
        (COARSE, role, quotient_left_coset(
            element,
            coarse_stabilizers[role],
            coarse_kernel,
            COARSE,
        ))
        for element in coarse_quotient
    }
    image_cells = {
        (COARSE, role, induced_cell_image(role, fine_cell[2]))
        for fine_cell in fine_cells
    }
    assert image_cells == coarse_cells

assert len(fine_quotient) == 6
assert len(coarse_quotient) == 2

print(
    "RESULT: PASS — the three representative-independent induced cell "
    "maps preserve stage and role labels and are surjective"
)
