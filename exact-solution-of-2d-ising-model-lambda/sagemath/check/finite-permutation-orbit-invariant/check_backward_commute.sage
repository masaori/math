# 準備の可換式を逆向きに使う
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i, n in fpoi_steps():
    assert (sigma[tau[fpoi_iterate(tau, n, i)]]) == (sigma[fpoi_iterate(tau, n, tau[i])])
    count += 1
assert count == 63773
print("backward_commute:", count, "exact checks; PASS")
