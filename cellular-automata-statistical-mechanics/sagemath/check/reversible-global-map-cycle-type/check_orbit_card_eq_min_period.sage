# claim_periodic_orbit_card_eq_min_period の検算。
# 元数 1,2,4 の配位集合上の全自己写像 261 個について、各周期点 q に対し
# θ(r) := F^r q （r < π(q)）の像が周期軌道 O_F(q) に一致すること、θ が単射であること、
# したがって |O_F(q)| = π(q) であることを、それぞれ分けて検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

checked_maps = 0
checked_points = 0
for size in (1, 2, 4):
    for table in all_maps(size):
        checked_maps += 1
        mp = preperiod_period_tables(table)
        for q in sorted(periodic_set(mp)):
            period = mp[q][1]
            assert period >= 1
            theta = []
            value = q
            for _ in range(period):
                theta.append(value)
                value = table[value]
            orbit_values = orbit_set(table, q)
            # 第一段: θ の像が O_F(q) に等しい。
            assert frozenset(theta) == orbit_values
            # 第二段: θ が単射である。
            assert len(set(theta)) == period
            # 結論: |O_F(q)| = π(q)。
            assert len(orbit_values) == period
            checked_points += 1

print(f"PASS maps={checked_maps} periodic_points={checked_points}")
