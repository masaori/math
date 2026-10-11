# 逆向き零回を挿入する
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i in fpoi_points():
    assert (sigma[i]) == (sigma[fpoi_iterate(tau, 0, i)])
    count += 1
assert count == 5039
print("backward_zero_inverse:", count, "exact checks; PASS")
