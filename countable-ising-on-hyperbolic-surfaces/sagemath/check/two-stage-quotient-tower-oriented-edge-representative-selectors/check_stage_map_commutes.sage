# SageMath: 細段代表元の段間像が像辺セルの粗段代表元に一致することを検証する
# 対象ラベル: def_quotient_tower_oriented_edge_representative_selector_compatibility
# 帰属: 有限置換群、有限商群、有限部分群、有限剰余類集合だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for fine_edge_cell in fine_edge_cells:
    coarse_edge_cell = induced_cell_image("edge", fine_edge_cell)
    assert coarse_edge_cell in coarse_edge_cells
    assert (
        stage_map(fine_representative_selector(fine_edge_cell))
        == coarse_representative_selector(coarse_edge_cell)
    )

print(
    "RESULT: PASS — the stage map sends every selected fine edge "
    "representative to the selected representative of its induced coarse edge cell"
)
