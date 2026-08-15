# 対象ラベル: claim_collision_shift
# 各衝突 F^i y = F^j y が反復後も保たれることを、各 0 <= k <= 2^|V| で検査する。
# 帰属: 有限集合と非負整数の等号・加法だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_collisions = 0
tested_shifts = 0
for stage_size, rule, initial, prefix in exhaustive_instances():
    bound = 2 ** stage_size
    for left, right in collision_pairs(prefix, bound):
        tested_collisions += 1
        for shift in range(bound + 1):
            assert prefix[left + shift] == prefix[right + shift]
            tested_shifts += 1

print("collisions checked: {}; shifted equalities checked: {}".format(tested_collisions, tested_shifts))
print("RESULT: PASS")
