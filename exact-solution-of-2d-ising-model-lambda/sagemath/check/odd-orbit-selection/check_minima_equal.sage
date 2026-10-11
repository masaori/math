# 反対称律による最小元の一致
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in oso_nonempty_cases():
    sigma, rho, subset, rank, old_points, new_points, old_min, new_min = row
    assert new_min == old_min
    count += 1
assert count > 0
print("minima_equal:", count, "exact checks; PASS")
