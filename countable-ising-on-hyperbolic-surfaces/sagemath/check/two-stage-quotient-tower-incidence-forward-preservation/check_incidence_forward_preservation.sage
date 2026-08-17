# SageMath: 全ての細段 incidence 対が粗段でも incident であることを検証する
# 対象ラベル: theorem_quotient_tower_coset_cell_incidence_forward_preservation
# 式ペア: (c_R,c_S) in I_fine => (bar(kappa)_R(c_R),bar(kappa)_S(c_S)) in I_coarse
# 帰属: 三つの形式的役割ラベルと有限剰余類集合だけを用いる。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for left_role, right_role, left_cell, right_cell in fine_incident_pairs:
    left_image = image_cell(left_role, left_cell)
    right_image = image_cell(right_role, right_cell)
    assert incident(left_image, right_image)

assert fine_incident_pairs

print(
    "RESULT: PASS — every fine-stage face-vertex, face-edge, and "
    "vertex-edge incidence pair remains incident after the induced maps"
)
