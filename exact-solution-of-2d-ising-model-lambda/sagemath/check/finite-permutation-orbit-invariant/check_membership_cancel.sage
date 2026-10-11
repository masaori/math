# 逆写像の打ち消しによる所属の同値
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for sigma, tau, i, j in fpoi_pairs():
    assert (j in fpoi_supports[(sigma, i)]) == (tau[sigma[j]] in fpoi_supports[(sigma, i)])
    count += 1
assert count == 29367
print("membership_cancel:", count, "exact checks; PASS")
