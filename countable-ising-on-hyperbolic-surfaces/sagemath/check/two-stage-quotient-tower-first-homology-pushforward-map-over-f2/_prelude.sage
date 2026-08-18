# SageMath: 商の塔が誘導する第一ホモロジー押し出し写像の共通有限データ
# 対象ラベル: def_quotient_tower_first_homology_pushforward_map_over_f2
# 帰属: 有限剰余類セル集合と F_2 上の有限商集合だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-first-cycle-pushforward-map-over-f2/_prelude.sage",
))

fine_cycle_tuples = tuple(
    tuple(cycle[cell] for cell in fine_edge_cells)
    for cycle in fine_first_cycles
)
coarse_cycle_tuples = tuple(
    tuple(cycle[cell] for cell in coarse_edge_cells)
    for cycle in coarse_first_cycles
)

load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-face-boundary-space-pushforward-over-f2/_prelude.sage",
))


def add_edge_coefficient_tuples(left, right):
    return tuple(F2(left_value + right_value) for left_value, right_value in zip(left, right))


def boundary_coset(representative, boundary_space):
    return frozenset(
        add_edge_coefficient_tuples(representative, boundary)
        for boundary in boundary_space
    )


fine_first_homology = frozenset(
    boundary_coset(cycle, fine_face_boundaries)
    for cycle in fine_cycle_tuples
)
coarse_first_homology = frozenset(
    boundary_coset(cycle, coarse_face_boundaries)
    for cycle in coarse_cycle_tuples
)


def pushforward_cycle_tuple(fine_cycle):
    fine_cycle_map = dict(zip(fine_edge_cells, fine_cycle))
    pushed_cycle_map = edge_coefficient_pushforward(fine_cycle_map)
    return tuple(pushed_cycle_map[cell] for cell in coarse_edge_cells)


def first_homology_pushforward(fine_homology_class):
    representative_images = {
        boundary_coset(
            pushforward_cycle_tuple(representative),
            coarse_face_boundaries,
        )
        for representative in fine_homology_class
    }
    assert len(representative_images) == 1
    return next(iter(representative_images))
