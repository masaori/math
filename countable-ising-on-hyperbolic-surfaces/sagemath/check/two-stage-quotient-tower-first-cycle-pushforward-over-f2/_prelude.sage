# SageMath: 商の塔における一次サイクルの押し出しの共通有限データ
# 対象ラベル: theorem_quotient_tower_first_cycle_pushforward_over_f2
# 帰属: 有限剰余類頂点・辺セル集合と F_2 上の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-first-boundary-pushforward-commutativity-over-f2/_prelude.sage",
))


def is_zero_coefficient_map(coefficients):
    return all(value == F2.zero() for value in coefficients.values())


fine_first_cycles = tuple(
    coefficients
    for coefficients in all_f2_coefficient_maps(fine_edge_cells)
    if is_zero_coefficient_map(fine_first_boundary(coefficients))
)

assert fine_first_cycles

