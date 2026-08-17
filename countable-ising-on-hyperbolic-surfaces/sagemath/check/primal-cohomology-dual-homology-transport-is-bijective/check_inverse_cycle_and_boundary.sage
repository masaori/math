# SageMath: 逆向き係数移送がサイクルと境界を対応する空間へ戻すことの厳密検算
# 対象ラベル: theorem_primal_cohomology_dual_homology_transport_is_bijective
# 式ペア: D_1^leftarrow(Cycle_1(C*)) subset Cocycle^1(C), D_1^leftarrow(Boundary_1(C*)) = Coboundary^1(C)
# 帰属: 形式的な有限ラベル集合と GF(2) 上の有限行列だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

for dual_cycle in dual_cycle_space:
    primal_coefficients = inverse_edge_transport * dual_cycle
    assert second_boundary.transpose() * primal_coefficients == 0
    assert coefficient_tuple(primal_coefficients) in {
        coefficient_tuple(primal_cocycle)
        for primal_cocycle in primal_cocycle_space
    }

inverse_boundary_image = {
    coefficient_tuple(inverse_edge_transport * dual_boundary)
    for dual_boundary in dual_boundary_space
}
primal_boundaries = {
    coefficient_tuple(primal_boundary)
    for primal_boundary in primal_coboundary_space
}
assert inverse_boundary_image == primal_boundaries

print(
    "RESULT: PASS — inverse edge transport sends every dual cycle to a "
    "primal cocycle and the dual boundary space exactly to the primal "
    "coboundary space"
)
