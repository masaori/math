# 逆向き零回では順向き一回を使う
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i in fpoi_points():
    assert (fpoi_iterate(sigma, 1, i)) == (fpoi_iterate(sigma, 0, sigma[i]))
    count += 1
assert count == 5039
print("backward_zero_successor:", count, "exact checks; PASS")
