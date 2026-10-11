# 最小元の等号を台の始点へ代入
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in oso_nonempty_cases():
    sigma, rho, subset, rank, old_points, new_points, old_min, new_min = row
    assert oso_supports[sigma][new_min] == oso_supports[sigma][old_min]
    count += 1
assert count > 0
print("basepoint_substitution:", count, "exact checks; PASS")
