# 対象ラベル: claim_global_flip_characterization
# 大域写像の一点反転による変化と局所規則の本質的依存台への所属の同値を、
# |V|<=3 の全 N(v) subset V、全局所真理値表、全 u in V で検査する。
# 帰属: 有限集合と 0/1 の等号だけを使う。R/C 脱出なし。

import os

_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, "_prelude.sage"))

tested = 0
for stage_size in range(4):
    stage = tuple(range(stage_size))
    global_inputs = configurations(stage_size)
    for neighborhood in subsets(stage):
        local_inputs = configurations(len(neighborhood))
        for outputs in product((0, 1), repeat=len(local_inputs)):
            local_table = dict(zip(local_inputs, outputs))
            global_table = {
                y: local_table[restrict_input(y, neighborhood)]
                for y in global_inputs
            }
            local_support_in_stage = {
                neighborhood[position]
                for position in support(local_table, local_inputs)
            }
            for u in stage:
                changed_by_global_flip = any(
                    global_table[y] != global_table[flip(y, u)]
                    for y in global_inputs
                )
                assert changed_by_global_flip == (u in local_support_in_stage)
                tested += 1

print("global flip equivalences checked: {}".format(tested))
print("RESULT: PASS")
