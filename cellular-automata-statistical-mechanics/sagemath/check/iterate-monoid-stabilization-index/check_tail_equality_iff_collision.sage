# 対象ラベル: claim_iterate_monoid_tail_equality_iff_collision_start
# すべての n（有限範囲 0..2j+2）について I_n(F) = I_{n+1}(F) ⟺ ∃p>0, F^n = F^{n+p} を、
# 順方向（F^n = F^{n+0} ∈ I_n = I_{n+1} から k を取り p = 1+k）と
# 逆方向（衝突 i=n, j=n+p と n+1 >= n から I_{n+1} = I_n）を分けて検査する。
# 帰属: 有限集合の写像の等号と非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
rows = 0
for stage_size, rule, table in exhaustive_instances():
    powers, i, j = monoid_and_collision(table)
    powers = power_tables(table, 4 * j + 6)
    for n in range(0, 2 * j + 3):
        tail_n = tail_by_definition(powers, n, n + j)
        tail_n1 = tail_by_definition(powers, n + 1, n + 1 + j)
        collision = [p for p in range(1, j + 1) if powers[n] == powers[n + p]]
        if tail_n == tail_n1:
            # 順方向: F^n = F^{n+0} ∈ I_n
            assert powers[n + 0] in tail_n
            assert powers[n] in tail_n1                      # 集合の等号
            ks = [k for k in range(0, j + 1) if powers[n] == powers[(n + 1) + k]]
            assert len(ks) > 0
            k = ks[0]
            assert (n + 1) + k == n + (1 + k)                # N の結合律
            p = 1 + k
            assert p > 0 and powers[n] == powers[n + p]
            assert len(collision) > 0
        else:
            assert len(collision) == 0
        if len(collision) > 0:
            # 逆方向: 衝突 i=n, j=n+p, n+1 >= n から I_{n+1} = I_n（claim_iterate_collision_stabilizes_tails）
            p = collision[0]
            assert n < n + p
            assert n + 1 >= n
            assert tail_n1 == tail_n
        rows += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("rows checked: {}".format(rows))
print("RESULT: PASS")
