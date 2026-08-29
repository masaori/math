# def_bijective_self_maps と claim_bijective_self_map_all_elements_periodic の検算。
# 元数 1,2,4,8 の配位集合について、単射な自己写像の個数が size! であること、
# 単射な自己写像では全ての配位の最小前周期が 0 で Per(F) = A^V になることを検査する。
# さらに元数 1,2,4 では、単射でない自己写像に最小前周期が正の配位が必ずあることも検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

factorials = {1: 1, 2: 2, 4: 24, 8: 40320}
checked_reversible = 0
for size in (1, 2, 4, 8):
    tables = injective_maps(size)
    assert len(tables) == factorials[size]
    for table in tables:
        # 単射性を写像表の像の元数で確認する。
        assert len(set(table)) == size
        mp = preperiod_period_tables(table)
        assert all(mp[y][0] == 0 for y in range(size))
        assert periodic_set(mp) == frozenset(range(size))
        checked_reversible += 1

checked_non_injective = 0
for size in (1, 2, 4):
    for table in all_maps(size):
        if len(set(table)) == size:
            continue
        mp = preperiod_period_tables(table)
        assert any(mp[y][0] > 0 for y in range(size))
        assert periodic_set(mp) != frozenset(range(size))
        checked_non_injective += 1

print(f"PASS reversible={checked_reversible} non_injective={checked_non_injective}")
