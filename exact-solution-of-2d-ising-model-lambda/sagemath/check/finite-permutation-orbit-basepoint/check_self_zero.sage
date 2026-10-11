# 自己所属の零回の証人
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, y in fpob_points():
    assert fpob_iterate(sigma, 0, y) == y
    count += 1
assert count == 5039
print("self_zero:", count, "exact checks; PASS")
