# SageMath: 主第一コホモロジーと双対第一ホモロジーの誘導写像の全単射性
# 対象ラベル: theorem_primal_cohomology_dual_homology_transport_is_bijective
# 帰属: 形式的な有限ラベル集合と GF(2) 上の有限行列だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(
    _dir,
    '..',
    'primal-cohomology-to-dual-homology-transport',
    '_prelude.sage',
))

inverse_edge_transport = edge_transport.inverse()


def induced_forward(primal_coset):
    images = {
        coset(edge_transport * vector(field, representative), dual_boundary_space)
        for representative in primal_coset
    }
    assert len(images) == 1
    return images.pop()


def induced_backward(dual_coset):
    images = {
        coset(inverse_edge_transport * vector(field, representative), primal_coboundary_space)
        for representative in dual_coset
    }
    assert len(images) == 1
    return images.pop()
