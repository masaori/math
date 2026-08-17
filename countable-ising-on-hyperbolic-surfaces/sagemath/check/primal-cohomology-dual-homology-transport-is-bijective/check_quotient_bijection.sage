# SageMath: 商上に誘導された二写像が左右逆写像であることの厳密検算
# 対象ラベル: theorem_primal_cohomology_dual_homology_transport_is_bijective
# 式ペア: Dbar_1^leftarrow Dbar_1 = id, Dbar_1 Dbar_1^leftarrow = id
# 帰属: 形式的な有限ラベル集合と GF(2) 上の有限行列だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

forward_image = {induced_forward(primal_coset) for primal_coset in primal_cohomology}
backward_image = {induced_backward(dual_coset) for dual_coset in dual_homology}

assert forward_image == dual_homology
assert backward_image == primal_cohomology

for primal_coset in primal_cohomology:
    assert induced_backward(induced_forward(primal_coset)) == primal_coset

for dual_coset in dual_homology:
    assert induced_forward(induced_backward(dual_coset)) == dual_coset

print(
    "RESULT: PASS — the induced quotient maps are mutually inverse and "
    "therefore bijective in the finite example"
)
