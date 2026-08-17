# SageMath: 細段 incidence の共通元が粗段剰余類の共通元へ移ることを検証する
# 対象ラベル: theorem_quotient_tower_coset_cell_incidence_forward_preservation
# 式ペア: x in g H_R^fine cap k H_S^fine => kappa(x) in kappa(g H_R^fine) cap kappa(k H_S^fine)
# 帰属: 有限商群と有限剰余類集合だけを用いる。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for left_role, right_role, left_cell, right_cell in fine_incident_pairs:
    witnesses = left_cell.intersection(right_cell)
    assert witnesses
    for witness in witnesses:
        image_witness = stage_map(witness)
        assert image_witness in {
            stage_map(element) for element in left_cell
        }
        assert image_witness in {
            stage_map(element) for element in right_cell
        }

print(
    "RESULT: PASS — every fine-stage incidence witness maps into both "
    "coarse-stage coset images"
)
