# 移した始点での帰納法の等式
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for f, n, y in fpoi_map_steps():
    assert (f[fpoi_iterate(f, n, f[y])]) == (fpoi_iterate(f, n, f[f[y]]))
    count += 1
assert count == 10026
print("commute_induction:", count, "exact checks; PASS")
