# SageMath: 誘導頂点写像が細段辺の終点を像辺の粗段終点へ送ることを検証する
# 対象ラベル: theorem_quotient_tower_oriented_edge_endpoint_map_preservation
# 式ペア: bar(kappa)_V(target_fine(C_E)) = target_coarse(bar(kappa)_E(C_E))
# 帰属: 有限置換群、有限商群、有限部分群、有限剰余類集合だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for fine_edge_cell in fine_edge_cells:
    coarse_edge_cell = induced_cell_image("edge", fine_edge_cell)
    image_of_fine_target = induced_cell_image(
        "vertex",
        fine_endpoint_cell(fine_edge_cell, "target"),
    )
    coarse_target = coarse_endpoint_cell(coarse_edge_cell, "target")
    assert image_of_fine_target == coarse_target

print(
    "RESULT: PASS — the induced vertex map sends every fine target endpoint "
    "to the target endpoint of the induced coarse edge"
)
