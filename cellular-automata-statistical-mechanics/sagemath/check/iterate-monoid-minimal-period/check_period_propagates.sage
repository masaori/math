# 対象ラベル: claim_iterate_monoid_period_propagates_after_collision_start
# 正周期の集合 Π_F = {p>0 | F^{μ_F} = F^{μ_F+p}} が空でないこと（μ_F が衝突開始位置）と、
# p ∈ Π_F, n >= μ_F ならば F^n = F^{n+p} を、人手証明の 4 行
# F^{n+p} = F^k ∘ F^{μ_F+p} = F^k ∘ F^{μ_F} = F^{μ_F+k} = F^n （n = μ_F + k）を一行ずつ検査する。
# 帰属: 有限集合の写像の等号と非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
rows = 0
for stage_size, rule, table in exhaustive_instances():
    powers, i, j = monoid_and_collision(table)
    mu = i
    powers = power_tables(table, 4 * j + 6)
    # Π_F は p = 1..j で尽くせる（指数 j 以上の反復写像は周期 j-i で繰り返す）
    Pi = [p for p in range(1, j + 1) if powers[mu] == powers[mu + p]]
    assert len(Pi) > 0                                    # μ_F は衝突開始位置なので空でない
    for p in Pi:
        for n in range(mu, mu + j + 2):                   # n >= μ_F の有限範囲
            k = n - mu
            assert k >= 0 and n == mu + k                 # n = μ_F + k
            lhs = powers[n + p]
            step1 = compose(powers[k], powers[mu + p])    # 反復回数の加法 F^{k+(μ+p)} = F^k ∘ F^{μ+p}
            assert lhs == step1
            step2 = compose(powers[k], powers[mu])        # p ∈ Π_F: F^{μ+p} = F^μ
            assert step1 == step2
            step3 = powers[mu + k]                        # 反復回数の加法
            assert step2 == step3
            assert step3 == powers[n]                     # n = μ_F + k
            rows += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("propagation rows checked: {}".format(rows))
print("RESULT: PASS")
