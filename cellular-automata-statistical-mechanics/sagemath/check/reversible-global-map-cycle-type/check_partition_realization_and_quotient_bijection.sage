# def_configuration_count_partitions、claim_reversible_cycle_type_realizes_every_partition、
# def_reversible_global_map_conjugacy_classes、claim_reversible_conjugacy_classes_bijection_partitions の検算。
# 元数 1,2,4,8 について、Part(2^|V|) の各分割が構成した巡回置換の巡回型として実現すること、
# 実現した写像が単射であること、単射な自己写像の巡回型の像が Part(2^|V|) 全体に一致すること、
# および元数 1,2,4 では有限置換による共役類の全数計算が巡回型の等しい類と一致することを検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

partition_counts = {1: 1, 2: 2, 4: 5, 8: 22}
checked_partitions = 0
for size in (1, 2, 4, 8):
    partitions = partitions_of(size)
    assert len(partitions) == len(set(partitions)) == partition_counts[size]
    for partition in partitions:
        assert all(part >= 1 for part in partition)
        assert sum(partition) == size
        table = realize_partition(size, partition)
        assert len(set(table)) == size
        assert cycle_type(table) == partition
        checked_partitions += 1

checked_classes = 0
for size in (1, 2, 4, 8):
    tables = injective_maps(size)
    image = frozenset(cycle_type(table) for table in tables)
    # 巡回型写像の像は Part(2^|V|) 全体である。
    assert image == frozenset(partitions_of(size))
    if size <= 4:
        classes = quotient_classes(tables)
        # 共役類の個数は分割の個数に等しい。
        assert len(classes) == partition_counts[size]
        for cls in classes:
            profiles = frozenset(cycle_type(table) for table in cls)
            # 一つの共役類の元は同じ巡回型を持ち、同じ巡回型の写像は同じ共役類に属する。
            assert len(profiles) == 1
            profile = min(profiles)
            assert cls == frozenset(table for table in tables if cycle_type(table) == profile)
            checked_classes += 1

print(f"PASS partitions={checked_partitions} conjugacy_classes={checked_classes}")
