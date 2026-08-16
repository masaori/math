# 対象ラベル: claim_iterate_monoid_first_stable_equals_min_collision_start
# 有限代表 P_F と合成で走査した後尾集合の列について、最初に I_n = I_{n+1} となる n が μ_F に等しく、
# 同じ走査（有限個の写像等号 = 2 値状態の等号の連言）で μ_F が決定されることを検査する。
# 帰属: 有限集合の写像の等号と非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
comparisons = 0
for stage_size, rule, table in exhaustive_instances():
    powers, i, j = monoid_and_collision(table)
    monoid = powers[:j]
    powers = power_tables(table, 3 * j + 4)
    def tail_by_scan(n):
        return frozenset(compose(powers[n], G) for G in monoid)
    first_stable = None
    for n in range(0, j + 1):
        comparisons += 1
        if tail_by_scan(n) == tail_by_scan(n + 1):
            first_stable = n
            break
    assert first_stable is not None
    # μ_F を定義どおり独立に求める
    mu = min(n for n in range(0, j + 1) if any(powers[n] == powers[n + p] for p in range(1, j + 1)))
    assert first_stable == mu
    # 走査は 2 値状態の等号の有限個の連言: 各写像等号は 2^|V| 個の配位番号の比較で、配位番号の等号は |V| 個の 2 値の等号
    assert all(len(G) == 2 ** stage_size for G in monoid)
    instances += 1

print("global maps checked: {}".format(instances))
print("tail comparisons: {}".format(comparisons))
print("RESULT: PASS")
