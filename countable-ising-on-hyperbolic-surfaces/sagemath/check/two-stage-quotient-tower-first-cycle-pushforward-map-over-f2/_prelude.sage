# SageMath: 商の塔が誘導する一次サイクル押し出し写像の共通有限データ
# 対象ラベル: def_quotient_tower_first_cycle_pushforward_map_over_f2
# 帰属: 有限剰余類辺セル集合と F_2 上の有限写像だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-first-cycle-pushforward-over-f2/_prelude.sage",
))


coarse_first_cycles = tuple(
    coefficients
    for coefficients in all_f2_coefficient_maps(coarse_edge_cells)
    if is_zero_coefficient_map(coarse_first_boundary(coefficients))
)


def first_cycle_pushforward(fine_cycle):
    assert fine_cycle in fine_first_cycles
    pushed_cycle = edge_coefficient_pushforward(fine_cycle)
    assert pushed_cycle in coarse_first_cycles
    return pushed_cycle
