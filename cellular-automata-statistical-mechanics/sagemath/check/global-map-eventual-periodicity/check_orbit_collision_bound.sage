# 対象ラベル: claim_orbit_collision
# 0 <= i < j <= 2^|V| を満たす軌道衝突が存在することを全数検査する。
# 帰属: 有限集合と非負整数の等号・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
for stage_size, rule, initial, prefix in exhaustive_instances():
    bound = 2 ** stage_size
    assert len(prefix[:bound + 1]) == bound + 1
    assert len(set(prefix[:bound + 1])) <= bound
    assert collision_pairs(prefix, bound)
    tested_instances += 1

print("orbit instances checked: {}".format(tested_instances))
print("RESULT: PASS")
