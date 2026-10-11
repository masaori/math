# 逆置換の台へ所属を移す
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i, j in fpoi_pairs():
    assert (sigma[j] in fpoi_supports[(tau, i)]) == (sigma[j] in fpoi_supports[(sigma, i)])
    count += 1
assert count == 29367
print("inverse_transfer:", count, "exact checks; PASS")
