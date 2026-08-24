# claim_conjugacy_class_count_finite_decidability の検算。
# 全写像表を有限列挙し、有限置換による共役類の分割と、再帰的前像木符号の有限比較による
# 相異なる符号の選出を独立に行い、両個数が一致することを検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

counts = []
for size, tables in maps_by_size().items():
    classes = quotient_classes(tables)
    distinct_codes = {code_data(table)[5] for table in tables}
    assert len(classes) == len(distinct_codes)
    counts.append((size, len(tables), len(classes)))

print("PASS " + " ".join(
    f"size={size}:maps={maps}:classes={classes}"
    for size, maps, classes in counts
))
