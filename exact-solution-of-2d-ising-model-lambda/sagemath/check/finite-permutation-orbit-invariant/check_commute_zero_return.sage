# 零回の反復へ戻す
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for f, y in fpoi_map_points():
    assert (f[y]) == (fpoi_iterate(f, 0, f[y]))
    count += 1
assert count == 1114
print("commute_zero_return:", count, "exact checks; PASS")
