# claim_conjugacy_class_code_image_bijection の検算。
# 元数 1・2・4 の全自己写像について、共役類の全代表が同じ写像符号を持つこと、
# 相異なる共役類の符号が異なること、全符号がある共役類から得られることを分けて検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

class_count = 0
representative_checks = 0
for size, tables in maps_by_size().items():
    classes = quotient_classes(tables)
    codes = []
    all_codes = {code_data(table)[5] for table in tables}
    for cls in classes:
        class_codes = {code_data(table)[5] for table in cls}
        # 代表に依存しない。
        assert len(class_codes) == 1
        representative_checks += len(cls)
        codes.append(next(iter(class_codes)))
    # 単射性。
    assert len(set(codes)) == len(classes)
    # 全射性。
    assert set(codes) == all_codes
    class_count += len(classes)

print(f"PASS classes={class_count} representatives={representative_checks}")
