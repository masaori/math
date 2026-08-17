# SageMath: 三つの細段役割安定化部分群の像を検証する
# 対象ラベル: def_quotient_tower_induced_coset_cell_maps
# 式ペア: kappa(H_R^fine) = H_R^coarse
# 帰属: 有限商群とその有限部分群だけを用いる。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for role in source_roles:
    stabilizer_image = {
        stage_map(element)
        for element in fine_stabilizers[role]
    }
    assert stabilizer_image == set(coarse_stabilizers[role])

print(
    "RESULT: PASS — the stage homomorphism maps each fine role "
    "stabilizer onto the corresponding coarse role stabilizer"
)
