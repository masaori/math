# 零回の反復の所属
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i, y in fpob_pairs():
    assert (fpob_iterate(sigma, 0, y) in fpob_supports[(sigma, i)]) == (y in fpob_supports[(sigma, i)])
    count += 1
assert count == 29367
print("forward_zero:", count, "exact checks; PASS")
