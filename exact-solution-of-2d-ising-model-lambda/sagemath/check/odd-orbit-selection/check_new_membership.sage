# 反転後の奇数点所属の定義
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row, j in oso_point_cases():
    sigma, rho, subset, rank, old_points, new_points, old_min, new_min = row
    assert (j in new_points) == (len(oso_supports[rho][j]) % 2 == 1)
    count += 1
assert count > 0
print("new_membership:", count, "exact checks; PASS")
