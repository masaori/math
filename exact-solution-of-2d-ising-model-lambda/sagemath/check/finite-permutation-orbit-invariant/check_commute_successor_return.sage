# 反復の後者へ戻す
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for f, n, y in fpoi_map_steps():
    assert (fpoi_iterate(f, n, f[f[y]])) == (fpoi_iterate(f, n + 1, f[y]))
    count += 1
assert count == 10026
print("commute_successor_return:", count, "exact checks; PASS")
