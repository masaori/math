# 反転後の集合での最小性
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in oso_nonempty_cases():
    sigma, rho, subset, rank, old_points, new_points, old_min, new_min = row
    assert rank[new_min] <= rank[old_min]
    count += 1
assert count > 0
print("new_min_le:", count, "exact checks; PASS")
