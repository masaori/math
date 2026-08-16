# 対象ラベル: claim_iterate_monoid_cycle_group_finite_decidability
# 有限真理値表から μ_F、λ_F、e_F を前章と同じ走査で求め、大域真理値表の合成で E_F、K_F=F^{e_F+1}、
# C_F の合成表を作り、各行で積が E_F となる列を走査して逆元を得ること（該当列がちょうど一つ）、
# 生成元 K_F の冪が C_F を尽くすこと、位数が λ_F であることを検査する。
# 帰属: 有限個の 2 値状態の等号検査と非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
table_comparisons = 0
inverse_scans = 0
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
    lam = 1
    current = compose(table, powers[mu])
    while current != powers[mu]:
        table_comparisons += 1
        lam += 1
        current = compose(table, current)
    table_comparisons += 1
    e = mu
    while e % lam != 0:
        e += 1

    # 巡回部と E_F, K_F を真理値表の合成だけで作る
    cycle = []
    g = identity_table(len(table))
    for _ in range(mu):
        g = compose(table, g)
    for _ in range(lam):
        cycle.append(g)
        g = compose(table, g)
    E = identity_table(len(table))
    for _ in range(e):
        E = compose(table, E)
    K = compose(table, E)
    assert compose(E, E) == E and E in cycle and K in cycle
    # 合成表
    cayley = [[compose(a, b) for b in cycle] for a in cycle]
    for row in cayley:
        for x in row:
            assert x in cycle
    # 各行で E_F となる列を走査して逆元（ちょうど一つ）
    for i, a in enumerate(cycle):
        hits = [j for j, x in enumerate(cayley[i]) if x == E]
        table_comparisons += lam
        inverse_scans += 1
        assert len(hits) == 1
        assert compose(cycle[hits[0]], a) == E
    # 生成元と位数
    gp, seen = E, []
    for _ in range(lam):
        seen.append(gp)
        gp = compose(gp, K)
    assert gp == E
    assert frozenset(seen) == frozenset(cycle) and len(frozenset(seen)) == lam
    ref_mu, ref_lam, ref_e, ref_powers = cycle_group_data(table)
    assert (mu, lam, e) == (ref_mu, ref_lam, ref_e)
    assert E == ref_powers[e] and K == ref_powers[e + 1]
    instances += 1

print("global maps checked: {}".format(instances))
print("truth-table comparisons: {}".format(table_comparisons))
print("inverse scans: {}".format(inverse_scans))
print("RESULT: PASS")
