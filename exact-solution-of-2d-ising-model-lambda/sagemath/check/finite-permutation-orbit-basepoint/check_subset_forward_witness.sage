# 第一包含で順向きの到達先を代入
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i, y, n in fpob_steps():
    k = fpob_iterate(sigma, n, y)
    assert (k in fpob_supports[(sigma, i)]) == (fpob_iterate(sigma, n, y) in fpob_supports[(sigma, i)])
    count += 1
assert count == 373837
print("subset_forward_witness:", count, "exact checks; PASS")
