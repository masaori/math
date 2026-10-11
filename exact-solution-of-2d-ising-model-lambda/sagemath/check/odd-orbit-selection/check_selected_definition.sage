# 反転後の選択台の定義
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in oso_nonempty_cases():
    sigma, rho, subset, rank, old_points, new_points, old_min, new_min = row
    assert oso_selected(rho, rank) == oso_supports[rho][new_min]
    count += 1
assert count > 0
print("selected_definition:", count, "exact checks; PASS")
