# 逆向きの後者へ戻す
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i, n in fpoi_steps():
    assert (sigma[fpoi_iterate(tau, n, tau[i])]) == (sigma[fpoi_iterate(tau, n + 1, i)])
    count += 1
assert count == 63773
print("backward_successor:", count, "exact checks; PASS")
