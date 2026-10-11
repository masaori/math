# 逆向きの到達先を代入する
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i, n in fpoi_steps():
    j = fpoi_iterate(tau, n + 1, i)
    assert (sigma[fpoi_iterate(tau, n + 1, i)]) == (sigma[j])
    count += 1
assert count == 63773
print("backward_witness:", count, "exact checks; PASS")
