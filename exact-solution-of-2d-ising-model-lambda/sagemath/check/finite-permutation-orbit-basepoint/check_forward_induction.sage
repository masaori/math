# 移した始点に帰納法の同値を使う
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i, y, n in fpob_steps():
    assert (fpob_iterate(sigma, n, sigma[y]) in fpob_supports[(sigma, i)]) == (sigma[y] in fpob_supports[(sigma, i)])
    count += 1
assert count == 373837
print("forward_induction:", count, "exact checks; PASS")
