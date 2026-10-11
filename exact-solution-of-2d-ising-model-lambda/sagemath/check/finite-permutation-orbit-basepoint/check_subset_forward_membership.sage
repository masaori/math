# 第一包含で順向きの所属を戻す
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i, y, n in fpob_steps():
    assert (fpob_iterate(sigma, n, y) in fpob_supports[(sigma, i)]) == (y in fpob_supports[(sigma, i)])
    count += 1
assert count == 373837
print("subset_forward_membership:", count, "exact checks; PASS")
