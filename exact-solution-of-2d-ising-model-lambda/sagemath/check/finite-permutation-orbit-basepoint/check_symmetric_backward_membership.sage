# 逆所属で逆向きの同値を逆に使う
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i, n in fpob_reached_points():
    j = fpob_iterate(tau, n, i)
    assert (i in fpob_supports[(sigma, j)]) == (fpob_iterate(tau, n, i) in fpob_supports[(sigma, j)])
    count += 1
assert count == 63773
print("symmetric_backward_membership:", count, "exact checks; PASS")
