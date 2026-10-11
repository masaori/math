# 準備の可換式を順向きに使う
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i, n in fpoi_steps():
    assert (fpoi_iterate(sigma, n, sigma[i])) == (sigma[fpoi_iterate(sigma, n, i)])
    count += 1
assert count == 63773
print("forward_commute:", count, "exact checks; PASS")
