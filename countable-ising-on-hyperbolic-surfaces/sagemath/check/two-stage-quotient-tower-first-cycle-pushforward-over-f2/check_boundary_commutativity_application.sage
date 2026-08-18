# SageMath: 一次境界写像と押し出しの可換性を細段一次サイクルへ適用する
# 対象ラベル: theorem_quotient_tower_first_cycle_pushforward_over_f2
# 式ペア: partial_1_coarse(bar(kappa)_{E,!}(c))
#          = bar(kappa)_{V,!}(partial_1_fine(c))
# 帰属: 有限剰余類頂点・辺セル集合と F_2 上の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for fine_cycle in fine_first_cycles:
    left_side = coarse_first_boundary(edge_coefficient_pushforward(fine_cycle))
    right_side = vertex_coefficient_pushforward(fine_first_boundary(fine_cycle))
    assert left_side == right_side

print(
    "RESULT: PASS — first-boundary pushforward commutativity holds for every "
    "fine first cycle"
)

