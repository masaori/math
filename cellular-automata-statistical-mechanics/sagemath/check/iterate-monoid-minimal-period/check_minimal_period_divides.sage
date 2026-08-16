# 対象ラベル: claim_iterate_monoid_minimal_period_divides_every_period
# λ_F = min Π_F について、各 p ∈ Π_F を p = q λ_F + r (0 <= r < λ_F) と除法で分け、
# 帰納法 F^{μ+r} = F^{μ+r+dλ} (d = 0..q) を一段ずつ、次に F^{μ+r+qλ} = F^{μ+p} = F^μ を検査し、
# r > 0 なら r ∈ Π_F かつ r < λ_F となって最小性に矛盾すること、したがって r = 0 で λ_F | p を検査する。
# 帰属: 有限集合の写像の等号と非負整数の除法だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
periods_checked = 0
induction_rows = 0
for stage_size, rule, table in exhaustive_instances():
    powers, i, j = monoid_and_collision(table)
    mu = i
    powers = power_tables(table, 4 * j + 6)
    Pi = [p for p in range(1, j + 1) if powers[mu] == powers[mu + p]]
    lam = min(Pi)                                          # N の整列性
    assert lam == j - i                                    # 最初の衝突の周期と一致（参考。人手証明は使わない）
    for p in Pi:
        q, r = divmod(p, lam)                              # 自然数の除法（一意）
        assert p == q * lam + r and 0 <= r < lam
        # 帰納法: F^{μ+r} = F^{μ+r+dλ}
        for d in range(0, q):
            assert mu + r + d * lam >= mu                  # 伝播 claim の適用条件
            assert powers[mu + r] == powers[mu + r + d * lam]           # 帰納法の仮定
            assert powers[mu + r + d * lam] == powers[mu + r + (d + 1) * lam]  # λ_F ∈ Π_F と伝播
            induction_rows += 1
        assert powers[mu + r] == powers[mu + r + q * lam]  # d = q
        assert powers[mu + r + q * lam] == powers[mu + p]  # p = qλ + r
        assert powers[mu + p] == powers[mu]                # p ∈ Π_F
        # 結論: F^{μ+r} = F^μ。r > 0 なら r ∈ Π_F で r < λ、最小性に矛盾
        if r > 0:
            assert r in Pi and r < lam
            raise AssertionError("minimality violated")
        assert r == 0 and p == q * lam and p % lam == 0    # λ_F | p
        periods_checked += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("periods checked: {}".format(periods_checked))
print("induction rows checked: {}".format(induction_rows))
print("RESULT: PASS")
