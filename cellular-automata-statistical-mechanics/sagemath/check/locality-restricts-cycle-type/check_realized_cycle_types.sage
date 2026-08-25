# claim_self_neighborhood_realized_cycle_types と claim_locality_restricts_cycle_type の検算。
# 3 セル自己近傍舞台の全 64 局所規則族から単射なものを抽出し、巡回型の像を直接決定する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

realized = set()
reversible_count = 0
for family in self_neighborhood_families(3):
    table = global_table(family)
    if len(set(table)) != 8:
        continue
    reversible_count += 1
    realized.add(cycle_type(table))

expected = {(1, 1, 1, 1, 1, 1, 1, 1), (2, 2, 2, 2)}
assert reversible_count == 8
assert realized == expected
assert (8,) in set(partitions_of(8))
assert (8,) not in realized
assert realized < set(partitions_of(8))
assert len(partitions_of(8)) == 22
assert 4 ** 3 == 64 > 22

print(f"PASS reversible={reversible_count} realized={sorted(realized)} partitions=22")

