# def_reversible_cycle_type と claim_reversible_cycle_type_sum の検算。
# 元数 1,2,4,8 の配位集合上の全ての単射な自己写像について、巡回型の各要素が
# 周期軌道の元数かつ基点の最小周期であること、要素が全て正であること、
# 重複度つき和が 2^|V| に等しいこと、したがって巡回型が Part(2^|V|) に属することを検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

part_sets = {size: frozenset(partitions_of(size)) for size in (1, 2, 4, 8)}
checked_maps = 0
checked_orbits = 0
for size in (1, 2, 4, 8):
    for table in injective_maps(size):
        checked_maps += 1
        mp = preperiod_period_tables(table)
        collection = orbits_of(table)
        for orbit_part in collection:
            # 巡回型の要素は軌道の元数であり、どの基点の最小周期とも等しい。
            for q in sorted(orbit_part):
                assert mp[q][1] == len(orbit_part)
            assert len(orbit_part) >= 1
            checked_orbits += 1
        profile = cycle_type(table)
        assert profile == tuple(sorted(len(orbit_part) for orbit_part in collection))
        assert sum(profile) == size
        assert profile in part_sets[size]

print(f"PASS maps={checked_maps} orbits={checked_orbits}")
