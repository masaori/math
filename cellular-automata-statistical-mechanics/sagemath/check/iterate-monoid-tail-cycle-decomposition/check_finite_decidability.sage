# 対象ラベル: claim_iterate_monoid_transient_cycle_finite_decidability
# 有限真理値表から μ_F と λ_F を走査し、T_F、C_F、|P_F| を有限決定できることを検査する。
# 帰属: 有限個の2値状態の等号検査と非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'iterate-monoid-minimal-period', '_prelude.sage'))

instances = 0
table_comparisons = 0
for stage_size, rule, table in exhaustive_instances():
    powers, collision_start, collision_end = monoid_and_collision(table)
    monoid = tuple(powers[:collision_end])

    def principal_tail(n):
        return frozenset(compose(powers[n], element) for element in monoid)

    mu = 0
    while principal_tail(mu) != principal_tail(mu + 1):
        table_comparisons += 1
        mu += 1
    table_comparisons += 1
    assert mu == collision_start

    lam = 1
    current = compose(table, powers[mu])
    while current != powers[mu]:
        table_comparisons += 1
        lam += 1
        current = compose(table, current)
    table_comparisons += 1

    transient = tuple(powers[n] for n in range(mu))
    cycle = tuple(powers[mu + r] for r in range(lam))
    assert len(set(transient)) == mu
    assert len(set(cycle)) == lam
    assert set(transient).isdisjoint(set(cycle))
    assert set(monoid) == set(transient).union(set(cycle))
    assert len(set(monoid)) == mu + lam
    instances += 1

print("global maps checked: {}".format(instances))
print("truth-table comparisons: {}".format(table_comparisons))
print("RESULT: PASS")
