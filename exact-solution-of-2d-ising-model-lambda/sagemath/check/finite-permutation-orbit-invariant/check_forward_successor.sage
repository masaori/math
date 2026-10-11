# 順向きの後者を展開する
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i, n in fpoi_steps():
    assert (fpoi_iterate(sigma, n + 1, i)) == (fpoi_iterate(sigma, n, sigma[i]))
    count += 1
assert count == 63773
print("forward_successor:", count, "exact checks; PASS")
