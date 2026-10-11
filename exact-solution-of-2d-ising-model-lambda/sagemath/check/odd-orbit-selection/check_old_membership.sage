# 元の奇数点所属へ戻す
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row, j in oso_point_cases():
    sigma, rho, subset, rank, old_points, new_points, old_min, new_min = row
    assert (len(oso_supports[sigma][j]) % 2 == 1) == (j in old_points)
    count += 1
assert count > 0
print("old_membership:", count, "exact checks; PASS")
