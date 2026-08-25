# 3 セル反例の外側での探索的な再検算。
# 1 <= |V| <= 5 の自己近傍舞台の全局所規則族を列挙し、可逆族の巡回型が
# 恒等族の {{1^(2^|V|)}} と、少なくとも一つ否定を含む族の {{2^(2^(|V|-1))}} に限られることを検査する。
# これは任意のセル数についての一般証明ではない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

checked_families = 0
checked_reversible = 0
for cell_count in range(1, 6):
    size = 2 ** cell_count
    realized = set()
    reversible = 0
    for family in self_neighborhood_families(cell_count):
        table = global_table(family)
        checked_families += 1
        if len(set(table)) != size:
            continue
        reversible += 1
        checked_reversible += 1
        realized.add(cycle_type(table))
    expected = {(1,) * size, (2,) * (size // 2)}
    assert reversible == 2 ** cell_count
    assert realized == expected

print(f"PASS families={checked_families} reversible={checked_reversible} cell_counts=1..5")
