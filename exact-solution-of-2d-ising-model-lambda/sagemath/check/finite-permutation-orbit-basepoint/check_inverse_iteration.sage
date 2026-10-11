# 逆置換に順向きの同値を使う
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i, y, n in fpob_steps():
    assert (fpob_iterate(tau, n, y) in fpob_supports[(tau, i)]) == (y in fpob_supports[(tau, i)])
    count += 1
assert count == 373837
print("inverse_iteration:", count, "exact checks; PASS")
