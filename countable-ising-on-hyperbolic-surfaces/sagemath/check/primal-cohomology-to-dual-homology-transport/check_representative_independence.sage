# SageMath: 誘導写像の代表元非依存性の厳密検算
# 対象ラベル: def_primal_cohomology_to_dual_homology_transport
# 式ペア: [c] = [c'] implies [D_1(c)] = [D_1(c')]
# 帰属: 形式的な有限ラベル集合と GF(2) 上の有限行列だけを用いる。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))


def induced_transport(primal_coset):
    images = set()
    for representative in primal_coset:
        images.add(
            coset(
                edge_transport * vector(field, representative),
                dual_boundary_space,
            )
        )
    assert len(images) == 1
    return images.pop()


def verify_representative_independence():
    cocycles = []
    for cocycle in primal_cocycle_space:
        cocycles.append(coefficient_tuple(cocycle))

    for left_coefficients in cocycles:
        for right_coefficients in cocycles:
            left = vector(field, left_coefficients)
            right = vector(field, right_coefficients)
            same_primal_class = (
                coset(left, primal_coboundary_space)
                == coset(right, primal_coboundary_space)
            )
            same_dual_class = (
                coset(edge_transport * left, dual_boundary_space)
                == coset(edge_transport * right, dual_boundary_space)
            )
            assert same_primal_class == same_dual_class

    induced_image = set()
    for primal_coset in primal_cohomology:
        induced_image.add(induced_transport(primal_coset))

    assert induced_image.issubset(dual_homology)
    assert len(induced_image) == len(primal_cohomology) == 2


verify_representative_independence()

print(
    "RESULT: PASS — every representative of a primal cohomology class "
    "maps to one dual homology class in the finite example"
)
