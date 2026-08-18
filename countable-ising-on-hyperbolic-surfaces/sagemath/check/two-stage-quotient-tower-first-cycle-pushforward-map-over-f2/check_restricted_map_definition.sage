# SageMath: 一次サイクル押し出し写像の始域・終域・作用を照合する
# 対象ラベル: def_quotient_tower_first_cycle_pushforward_map_over_f2

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for fine_cycle in fine_first_cycles:
    pushed_cycle = first_cycle_pushforward(fine_cycle)
    assert pushed_cycle in coarse_first_cycles
    assert pushed_cycle == edge_coefficient_pushforward(fine_cycle)

print(
    "RESULT: PASS — the restricted first-cycle pushforward has the fine "
    "first-cycle space as domain, the coarse first-cycle space as codomain, "
    "and agrees with edge-coefficient pushforward on every fine first cycle"
)
