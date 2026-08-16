# 対象ラベル: claim_iterate_monoid_cycle_idempotent_finite_decidability
# 有限真理値表から μ_F（後尾集合の最初の安定）、λ_F（正周期の逐次走査）、e_F（μ_F から λ_F | n を順に判定）を求め、
# 局所真理値表から作った大域真理値表を e_F 回合成して E_F を得ることを検査する。
# 帰属: 有限個の 2 値状態の等号検査と非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
table_comparisons = 0
divisibility_tests = 0
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

    n = mu
    while n % lam != 0:
        divisibility_tests += 1
        n += 1
    divisibility_tests += 1
    e = n
    assert e == min(k for k in range(mu * lam + 1) if mu <= k and k % lam == 0)

    candidate = identity_table(len(table))
    for _ in range(e):
        candidate = compose(table, candidate)
    ref_mu, ref_lam, ref_powers = mu_lambda_powers(table)
    assert (mu, lam) == (ref_mu, ref_lam)
    assert candidate == ref_powers[e]
    assert compose(candidate, candidate) == candidate
    assert candidate in cycle_part(mu, lam, ref_powers)
    instances += 1

print("global maps checked: {}".format(instances))
print("truth-table comparisons: {}".format(table_comparisons))
print("divisibility tests: {}".format(divisibility_tests))
print("RESULT: PASS")
