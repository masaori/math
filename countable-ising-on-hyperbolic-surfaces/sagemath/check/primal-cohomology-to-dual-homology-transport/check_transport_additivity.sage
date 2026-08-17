# SageMath: 主辺係数移送が成分ごとの加法を保つことの厳密検算
# 対象ラベル: def_primal_cohomology_to_dual_homology_transport
# 式ペア: D_1(c + a_0) = D_1(c) + D_1(a_0)
# 帰属: 形式的な有限ラベル集合と GF(2) 上の有限行列だけを用いる。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

def verify_transport_additivity():
    cocycles = []
    for cocycle in primal_cocycle_space:
        cocycles.append(coefficient_tuple(cocycle))
    coboundaries = []
    for coboundary in primal_coboundary_space:
        coboundaries.append(coefficient_tuple(coboundary))

    for cocycle_coefficients in cocycles:
        for coboundary_coefficients in coboundaries:
            cocycle = vector(field, cocycle_coefficients)
            coboundary = vector(field, coboundary_coefficients)
            left = edge_transport * (cocycle + coboundary)
            right = edge_transport * cocycle + edge_transport * coboundary
            assert left == right
            for index in range(len(left)):
                assert left[index] == right[index]


verify_transport_additivity()

print(
    "RESULT: PASS — edge transport preserves every componentwise sum of "
    "a primal cocycle and a primal coboundary"
)
