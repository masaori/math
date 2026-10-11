# 元の置換の台へ戻す
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i, y in fpob_pairs():
    assert (y in fpob_supports[(tau, i)]) == (y in fpob_supports[(sigma, i)])
    count += 1
assert count == 29367
print("inverse_return:", count, "exact checks; PASS")
