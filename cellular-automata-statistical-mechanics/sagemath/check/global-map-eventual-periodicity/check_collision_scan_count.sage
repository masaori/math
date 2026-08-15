# 対象ラベル: claim_collision_finite_decidability
# 0 <= i < j <= M の組数が M(M+1)/2 であり、走査がその回数以内に衝突を返すことを検査する。
# 帰属: 有限集合と非負整数の等号・四則演算だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_configuration_equalities = 0
tested_state_equalities = 0
for stage_size, rule, initial, prefix in exhaustive_instances():
    bound = 2 ** stage_size
    pairs = tuple(
        (left, right)
        for left in range(bound + 1)
        for right in range(left + 1, bound + 1)
    )
    assert len(pairs) == bound * (bound + 1) // 2

    found = False
    for left, right in pairs:
        tested_configuration_equalities += 1
        coordinate_equalities = tuple(
            prefix[left][cell] == prefix[right][cell]
            for cell in range(stage_size)
        )
        tested_state_equalities += len(coordinate_equalities)
        assert (prefix[left] == prefix[right]) == all(coordinate_equalities)
        if prefix[left] == prefix[right]:
            found = True
            break
    assert found
    tested_instances += 1

print("orbit instances checked: {}; configuration equalities checked: {}; state equalities checked: {}".format(
    tested_instances, tested_configuration_equalities, tested_state_equalities
))
print("RESULT: PASS")
