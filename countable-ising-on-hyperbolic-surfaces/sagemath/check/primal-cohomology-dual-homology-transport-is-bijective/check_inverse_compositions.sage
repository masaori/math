# SageMath: 係数移送と逆向き係数移送の左右合成の厳密検算
# 対象ラベル: theorem_primal_cohomology_dual_homology_transport_is_bijective
# 式ペア: D_1^leftarrow D_1(c) = c, D_1 D_1^leftarrow(z*) = z*
# 帰属: 形式的な有限ラベル集合と GF(2) 上の有限行列だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

for primal_cocycle in primal_cocycle_space:
    assert inverse_edge_transport * edge_transport * primal_cocycle == primal_cocycle

for dual_cycle in dual_cycle_space:
    assert edge_transport * inverse_edge_transport * dual_cycle == dual_cycle

print(
    "RESULT: PASS — forward and inverse edge transport compose to the "
    "identity on every primal cocycle and every dual cycle"
)
