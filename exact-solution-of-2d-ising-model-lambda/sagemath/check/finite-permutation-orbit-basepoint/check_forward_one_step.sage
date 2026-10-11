# 一歩の不変性を使う
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i, y in fpob_pairs():
    assert (sigma[y] in fpob_supports[(sigma, i)]) == (y in fpob_supports[(sigma, i)])
    count += 1
assert count == 29367
print("forward_one_step:", count, "exact checks; PASS")
