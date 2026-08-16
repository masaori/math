# 対象ラベル: claim_iterate_monoid_stable_tail_equals_cycle_part
# 併せて検証するラベル: claim_iterate_monoid_cycle_part_pairwise_distinct
# 安定後尾が最小正周期の一周期分で尽くされ、各代表が相異なることを検査する。
# 帰属: 有限集合の写像の等号、非負整数の除法だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'iterate-monoid-minimal-period', '_prelude.sage'))

instances = 0
reductions = 0
distinct_pairs = 0
for stage_size, rule, table in exhaustive_instances():
    _, mu, collision_end = monoid_and_collision(table)
    powers = power_tables(table, mu + 3 * collision_end + 6)
    lam = min(p for p in range(1, collision_end + 1) if powers[mu] == powers[mu + p])
    cycle = frozenset(powers[mu + r] for r in range(lam))
    tail = frozenset(powers[mu + k] for k in range(3 * collision_end + 1))
    assert tail == cycle
    for k in range(3 * collision_end + 1):
        q, r = divmod(k, lam)
        assert k == q * lam + r and 0 <= r < lam
        assert powers[mu + k] == powers[mu + r]
        reductions += 1
    for r in range(lam):
        for s in range(r + 1, lam):
            assert powers[mu + r] != powers[mu + s]
            distinct_pairs += 1
    assert len(cycle) == lam
    instances += 1

print("global maps checked: {}".format(instances))
print("tail reductions checked: {}".format(reductions))
print("distinct cycle pairs checked: {}".format(distinct_pairs))
print("RESULT: PASS")
