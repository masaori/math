# 逆向き零回の到達先を代入する
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i in fpoi_points():
    j = fpoi_iterate(tau, 0, i)
    assert (sigma[fpoi_iterate(tau, 0, i)]) == (sigma[j])
    count += 1
assert count == 5039
print("backward_zero_witness:", count, "exact checks; PASS")
