# 反転による台の保存
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in oso_nonempty_cases():
    sigma, rho, subset, rank, old_points, new_points, old_min, new_min = row
    assert oso_supports[rho][new_min] == oso_supports[sigma][new_min]
    count += 1
assert count > 0
print("support_preserved:", count, "exact checks; PASS")
