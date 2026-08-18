# SageMath: 第一ホモロジー押し出し写像の始域・終域・作用を検算する
# 対象ラベル: def_quotient_tower_first_homology_pushforward_map_over_f2

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_classes = 0
for fine_homology_class in fine_first_homology:
    image = first_homology_pushforward(fine_homology_class)
    assert image in coarse_first_homology
    for representative in fine_homology_class:
        expected = boundary_coset(
            pushforward_cycle_tuple(representative),
            coarse_face_boundaries,
        )
        assert image == expected
    checked_classes += 1

print(
    "RESULT: PASS — the induced map has the fine first homology as domain, "
    "the coarse first homology as codomain, and sends each class to the class "
    f"of its pushed-forward cycle ({checked_classes} classes checked)"
)
