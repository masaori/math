# 対象ラベル: claim_iterate_monoid_tails_strict_then_stable
# n < μ_F では I_{n+1}(F) ⊊ I_n(F)（包含は tails_descend、等号なら衝突開始位置になり最小性に矛盾）、
# n >= μ_F では I_n(F) = I_{μ_F}(F)（μ_F での衝突と collision_stabilizes_tails）を有限範囲で検査する。
# 帰属: 有限集合の写像の等号と非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
strict_rows = 0
stable_rows = 0
for stage_size, rule, table in exhaustive_instances():
    powers, i, j = monoid_and_collision(table)
    powers = power_tables(table, 4 * j + 6)
    mu = i
    tail_mu = tail_by_definition(powers, mu, mu + j)
    for n in range(0, mu):
        tail_n = tail_by_definition(powers, n, n + j)
        tail_n1 = tail_by_definition(powers, n + 1, n + 1 + j)
        assert tail_n1 <= tail_n                             # claim_iterate_monoid_tails_descend
        assert not any(powers[n] == powers[n + p] for p in range(1, j + 1))  # n は衝突開始位置でない
        assert tail_n1 != tail_n                             # 等号なら同値により衝突開始位置になる
        assert tail_n1 < tail_n                              # 真部分集合
        strict_rows += 1
    p = j - i
    assert p > 0 and powers[mu] == powers[mu + p]            # μ_F は衝突開始位置
    for n in range(mu, 2 * j + 3):
        assert tail_by_definition(powers, n, n + j) == tail_mu   # 安定
        stable_rows += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("strict rows: {}, stable rows: {}".format(strict_rows, stable_rows))
print("RESULT: PASS")
