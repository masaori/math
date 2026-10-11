# 軌道長の保存による奇数性の一致
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row, j in oso_point_cases():
    sigma, rho, subset, rank, old_points, new_points, old_min, new_min = row
    assert (len(oso_supports[rho][j]) % 2 == 1) == (len(oso_supports[sigma][j]) % 2 == 1)
    count += 1
assert count > 0
print("odd_length_preserved:", count, "exact checks; PASS")
