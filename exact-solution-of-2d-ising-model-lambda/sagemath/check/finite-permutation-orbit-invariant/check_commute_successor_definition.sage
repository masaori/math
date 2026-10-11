# 反復の後者を展開する
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for f, n, y in fpoi_map_steps():
    assert (f[fpoi_iterate(f, n + 1, y)]) == (f[fpoi_iterate(f, n, f[y])])
    count += 1
assert count == 10026
print("commute_successor_definition:", count, "exact checks; PASS")
