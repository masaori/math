# SageMath: 左剰余類の像が像代表元による粗段左剰余類に等しいことを検証する
# 対象ラベル: theorem_quotient_tower_coset_cell_incidence_forward_preservation
# 式ペア: kappa(g H_R^fine) = kappa(g) kappa(H_R^fine) = kappa(g) H_R^coarse
# 帰属: 有限商群、有限部分群、有限剰余類集合だけを用いる。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for role in source_roles:
    for fine_cell in fine_cells[role]:
        direct_image = frozenset(stage_map(element) for element in fine_cell)
        induced_image = image_cell(role, fine_cell)
        assert direct_image == induced_image

print(
    "RESULT: PASS — every fine left-coset image equals the coarse left "
    "coset used by the induced cell map"
)
