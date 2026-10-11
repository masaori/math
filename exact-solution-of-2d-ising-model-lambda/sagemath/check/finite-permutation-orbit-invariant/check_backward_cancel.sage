# 逆写像の打ち消し
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i, n in fpoi_steps():
    assert (fpoi_iterate(tau, n, i)) == (sigma[tau[fpoi_iterate(tau, n, i)]])
    count += 1
assert count == 63773
print("backward_cancel:", count, "exact checks; PASS")
