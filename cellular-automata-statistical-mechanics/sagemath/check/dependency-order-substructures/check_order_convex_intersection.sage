# 対象ラベル: claim_order_convex_intersection
# 二つの順序凸部分集合の共通部分が順序凸であることを全数検査する。
# 帰属: 有限集合の共通部分・所属だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_pairs = 0
for tau, stage_size, event_set, dependency in exhaustive_instances():
    order = reflexive_order(event_set, dependency)
    convex_subsets = tuple(subset for subset in powerset(event_set) if is_order_convex(subset, event_set, order))
    for first in convex_subsets:
        for second in convex_subsets:
            assert is_order_convex(first & second, event_set, order)
            tested_pairs += 1
    tested_instances += 1

print("instances checked: {}; convex-set pairs checked: {}".format(tested_instances, tested_pairs))
print("RESULT: PASS")
