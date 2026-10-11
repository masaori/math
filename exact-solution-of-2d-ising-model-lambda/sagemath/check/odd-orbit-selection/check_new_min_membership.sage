# 反転後の最小元を元の集合へ移す
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in oso_nonempty_cases():
    sigma, rho, subset, rank, old_points, new_points, old_min, new_min = row
    assert (new_min in old_points) == (new_min in new_points)
    count += 1
assert count > 0
print("new_min_membership:", count, "exact checks; PASS")
