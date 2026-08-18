# SageMath: 細段一次サイクルの辺係数押し出しが粗段一次サイクルになることを直接検算する
# 対象ラベル: theorem_quotient_tower_first_cycle_pushforward_over_f2
# 結論: bar(kappa)_{E,!}(c) in ker(partial_1_coarse)
# 帰属: 有限剰余類頂点・辺セル集合と F_2 上の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_cycles = 0
checked_components = 0

for fine_cycle in fine_first_cycles:
    coarse_boundary = coarse_first_boundary(
        edge_coefficient_pushforward(fine_cycle)
    )
    assert is_zero_coefficient_map(coarse_boundary)
    checked_cycles += 1
    checked_components += len(coarse_vertex_cells)

assert checked_cycles == len(fine_first_cycles)
assert checked_components == checked_cycles * len(coarse_vertex_cells)

print(
    "RESULT: PASS — edge-coefficient pushforward sends every fine first "
    "cycle into the coarse first-cycle space"
)

