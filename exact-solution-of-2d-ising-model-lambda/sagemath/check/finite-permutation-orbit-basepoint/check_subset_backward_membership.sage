# 第一包含で逆向きの所属を戻す
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i, y, n in fpob_steps():
    assert (fpob_iterate(tau, n, y) in fpob_supports[(sigma, i)]) == (y in fpob_supports[(sigma, i)])
    count += 1
assert count == 373837
print("subset_backward_membership:", count, "exact checks; PASS")
