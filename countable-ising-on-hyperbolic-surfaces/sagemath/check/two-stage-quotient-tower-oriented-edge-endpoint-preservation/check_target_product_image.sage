# SageMath: 終点代表元の積が段間群準同型で積へ送られることを検証する
# 対象ラベル: theorem_quotient_tower_oriented_edge_endpoint_map_preservation
# 式ペア: kappa(eta_fine(C_E) r_E_fine) = kappa(eta_fine(C_E)) kappa(r_E_fine)
# 帰属: 有限置換群と有限商群だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for fine_edge_cell in fine_edge_cells:
    fine_representative = fine_representative_selector(fine_edge_cell)
    fine_target_representative = quotient_product(
        fine_representative,
        fine_roles["edge"],
        fine_kernel,
        FINE,
    )
    left_side = stage_map(fine_target_representative)
    right_side = quotient_product(
        stage_map(fine_representative),
        stage_map(fine_roles["edge"]),
        coarse_kernel,
        COARSE,
    )
    assert left_side == right_side

print(
    "RESULT: PASS — the stage homomorphism sends every selected fine target "
    "representative product to the product of the two stage images"
)
