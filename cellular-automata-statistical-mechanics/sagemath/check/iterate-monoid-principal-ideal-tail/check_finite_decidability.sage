# 対象ラベル: claim_iterate_monoid_tail_finite_decidability
# 有限代表 P_F と合成表から I_n(F) = {F^n ∘ G | G in P_F} を走査で作り、I_0, ..., I_i の比較だけで
# 相異なる後尾集合の列と最初の I_n = I_{n+1} の位置が決まること（n >= i で新しい後尾集合が現れないこと）を検査する。
# 帰属: 有限集合の写像の等号（2 値状態の等号の連言）と非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
distinct_total = 0
for stage_size, rule, table in exhaustive_instances():
    powers, i, j = monoid_and_collision(table)
    monoid = powers[:j]
    powers = power_tables(table, 3 * j + 4)
    # 走査による I_n（P_F 上）
    def tail_by_scan(n):
        return frozenset(compose(powers[n], G) for G in monoid)
    scanned = [tail_by_scan(n) for n in range(0, i + 2)]
    for n in range(0, i + 2):
        assert scanned[n] == tail_by_definition(powers, n, n + j)   # 定義との一致
    # 相異なる後尾集合の列と最初の安定位置
    first_stable = None
    for n in range(0, i + 1):
        if scanned[n] == scanned[n + 1]:
            first_stable = n
            break
    assert first_stable is not None and first_stable <= i          # I_i = I_{i+1} は衝突から従う
    distinct = []
    for n in range(0, first_stable + 1):
        assert scanned[n] not in distinct                           # 安定前は真に減少
        distinct.append(scanned[n])
    for n in range(0, first_stable):
        assert scanned[n + 1] < scanned[n]                          # 真部分集合
    # n >= i では新しい後尾集合は現れない（有限範囲）
    for n in range(i, 2 * j + 3):
        assert tail_by_definition(powers, n, n + j) == scanned[i]
    distinct_total += len(distinct)
    instances += 1

print("global maps checked: {}".format(instances))
print("distinct tails total: {}".format(distinct_total))
print("RESULT: PASS")
