# claim_conjugacy_class_relation_is_equivalence の検算。
# 元数 1・2・4 の全自己写像について共役類を有限置換の全数走査で作り、
# 反射律、対称律、推移律を共役類の一致・非交差として検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

table_count = 0
related_pairs = 0
class_count = 0
for size, tables in maps_by_size().items():
    classes = quotient_classes(tables)
    class_count += len(classes)
    assert set().union(*(set(cls) for cls in classes)) == set(tables)
    for index, cls in enumerate(classes):
        # 反射律。
        assert all(table in cls for table in cls)
        # 対称律と推移律: 各元からの共役類が同じ cls である。
        for table in cls:
            assert conjugacy_class(table) == cls
        # 異なる同値類は非交差。
        assert all(cls.isdisjoint(other) for other in classes[index + 1:])
        related_pairs += len(cls) ** 2
    table_count += len(tables)

print(f"PASS tables={table_count} classes={class_count} related_pairs={related_pairs}")
