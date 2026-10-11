# 順向き零回を消す
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i in fpoi_points():
    assert (fpoi_iterate(sigma, 0, sigma[i])) == (sigma[i])
    count += 1
assert count == 5039
print("backward_zero_value:", count, "exact checks; PASS")
