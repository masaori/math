# claim_stage_global_maps_count の具体舞台での検算。
# 1 <= |V| <= 6 の自己近傍舞台で全 4^|V| 局所規則族を走査し、
# 異なる族が異なる大域写像を与え、個数が (2^(2^1))^|V| に等しいことを検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

checked_families = 0
for cell_count in range(1, 7):
    families = self_neighborhood_families(cell_count)
    tables = tuple(global_table(family) for family in families)
    assert len(families) == 4 ** cell_count
    assert len(set(tables)) == len(families)
    checked_families += len(families)

print(f"PASS families={checked_families}")

