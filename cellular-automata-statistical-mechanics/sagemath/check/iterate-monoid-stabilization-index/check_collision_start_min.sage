# 対象ラベル: def_iterate_monoid_collision_start
# 衝突開始位置 {n | ∃p>0, F^n = F^{n+p}} が空でなく、その最小値 μ_F が有限走査で得られること、
# および μ_F が最初の衝突 F^i = F^j (i<j, F^0..F^{j-1} 相異なる) の i に一致することを検査する。
# 帰属: 有限集合の写像の等号と非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
for stage_size, rule, table in exhaustive_instances():
    powers, i, j = monoid_and_collision(table)
    powers = power_tables(table, 3 * j + 4)
    period = j - i
    def is_collision_start(n):
        # p は 1..j の範囲で尽くせる（F^{n+p} は指数 j 以上で周期 j-i を持つ）
        return any(powers[n] == powers[n + p] for p in range(1, j + 1))
    starts = [n for n in range(0, j + 1) if is_collision_start(n)]
    assert len(starts) > 0                                   # 存在（claim_iterate_map_collision_finite_representatives）
    mu = min(starts)                                         # N の整列性
    assert mu == i                                           # 最初の衝突の指数と一致
    assert powers[mu] == powers[mu + period] and period > 0  # 証人 p = j - i
    for n in range(0, mu):
        assert not is_collision_start(n)                     # 最小性
    instances += 1

print("global maps checked: {}".format(instances))
print("RESULT: PASS")
