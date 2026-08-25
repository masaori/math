# claim_fixed_neighborhood_reversible_maps_not_composition_closed の結論の検算。
# 固定近傍 N で表せる大域写像 M(V, N) を全 64 通り列挙し、F o F がその中に無いことを直接検査する。
# 併せて、M(V, N) の元は全て各座標の依存台が N(v) に含まれることを確認する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

representable = fixed_neighborhood_global_tables()
assert len(representable) == 4 ** CELL_COUNT   # 一元近傍の局所規則は 4 通り

# claim_representable_implies_support_subset の検算（この舞台での全数確認）
for table in representable:
    for v in range(CELL_COUNT):
        assert support(coordinate_map(table, v)).issubset(set(neighborhood(v)))

F = shift_global_table()
FF = compose(F, F)

assert F in representable          # F は表せる
assert FF not in representable     # F o F は表せない

# 可逆な元だけに絞っても閉じないこと
reversible = {table for table in representable if len(set(table)) == len(table)}
assert F in reversible
assert FF not in reversible
assert compose(F, F) == FF

print(f"PASS representable={len(representable)} reversible={len(reversible)}")
