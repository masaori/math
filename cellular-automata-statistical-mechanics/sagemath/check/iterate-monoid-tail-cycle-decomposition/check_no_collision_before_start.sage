# 対象ラベル: claim_iterate_monoid_no_collision_before_min_start
# a <= b, a < μ_F で F^a = F^b iff a = b、また a < μ_F <= n なら F^a != F^n を検査する。
# 帰属: 有限集合の写像の等号と非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'iterate-monoid-minimal-period', '_prelude.sage'))

instances = 0
before_pairs = 0
cross_pairs = 0
for stage_size, rule, table in exhaustive_instances():
    _, mu, collision_end = monoid_and_collision(table)
    powers = power_tables(table, collision_end + 2)
    for a in range(mu):
        for b in range(a, mu):
            assert (powers[a] == powers[b]) == (a == b)
            before_pairs += 1
        for n in range(mu, collision_end + 2):
            assert powers[a] != powers[n]
            cross_pairs += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("pairs before collision start: {}".format(before_pairs))
print("transient/stable pairs checked: {}".format(cross_pairs))
print("RESULT: PASS")
