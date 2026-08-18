# SageMath: 第一ホモロジー押し出し写像の代表元非依存性を検算する
# 対象ラベル: def_quotient_tower_first_homology_pushforward_map_over_f2

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_representatives = 0
for fine_homology_class in fine_first_homology:
    images = set()
    for representative in fine_homology_class:
        images.add(boundary_coset(
            pushforward_cycle_tuple(representative),
            coarse_face_boundaries,
        ))
        checked_representatives += 1
    assert len(images) == 1

print(
    "RESULT: PASS — every representative of each fine first-homology class "
    f"has the same coarse first-homology image ({checked_representatives} representatives checked)"
)
