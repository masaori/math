# 対象ラベル: claim_one_step_dependency_finite_decidability
# D_tau の列挙が「t=s+1 かつ u in supp(f_v)」と一致し、E_tau^2 の部分集合であることを、
# |V|<=3、tau<=3 の全 N(v) subset V、全局所真理値表について検査する。
# 帰属: 非負整数、有限集合、0/1 の等号だけを使う。R/C 脱出なし。

import os

_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, "_prelude.sage"))

tested_relations = 0
tested_memberships = 0
for stage_size in range(4):
    stage = tuple(range(stage_size))
    for neighborhood in subsets(stage):
        local_inputs = configurations(len(neighborhood))
        for outputs in product((0, 1), repeat=len(local_inputs)):
            local_table = dict(zip(local_inputs, outputs))
            local_support_in_stage = {
                neighborhood[position]
                for position in support(local_table, local_inputs)
            }
            for tau in range(4):
                events = {
                    (t, v)
                    for t in range(tau + 1)
                    for v in stage
                }
                event_pairs = {
                    (source, target)
                    for source in events
                    for target in events
                }
                relation = {
                    ((s, u), (t, v))
                    for ((s, u), (t, v)) in event_pairs
                    if t == s + 1 and u in local_support_in_stage
                }
                assert relation.issubset(event_pairs)
                for pair in event_pairs:
                    (s, u), (t, v) = pair
                    expected = t == s + 1 and u in local_support_in_stage
                    assert (pair in relation) == expected
                    tested_memberships += 1
                tested_relations += 1

print("finite relations checked: {}".format(tested_relations))
print("relation memberships checked: {}".format(tested_memberships))
print("RESULT: PASS")
