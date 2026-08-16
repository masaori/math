# 対象ラベル: claim_iterate_monoid_transient_cycle_partition_cardinality
# P_F = T_F sqcup C_F と |P_F| = μ_F + λ_F を検査する。
# 帰属: 有限集合の写像の等号と非負整数の加法だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'iterate-monoid-minimal-period', '_prelude.sage'))

instances = 0
monoid_elements = 0
for stage_size, rule, table in exhaustive_instances():
    powers, mu, collision_end = monoid_and_collision(table)
    lam = min(p for p in range(1, collision_end + 1) if powers[mu] == powers[mu + p])
    monoid = frozenset(powers[:collision_end])
    transient = frozenset(powers[n] for n in range(mu))
    cycle = frozenset(powers[mu + r] for r in range(lam))
    assert transient.isdisjoint(cycle)
    assert monoid == transient.union(cycle)
    assert len(transient) == mu
    assert len(cycle) == lam
    assert len(monoid) == len(transient) + len(cycle)
    assert len(monoid) == mu + lam
    monoid_elements += len(monoid)
    instances += 1

print("global maps checked: {}".format(instances))
print("monoid elements counted: {}".format(monoid_elements))
print("RESULT: PASS")
