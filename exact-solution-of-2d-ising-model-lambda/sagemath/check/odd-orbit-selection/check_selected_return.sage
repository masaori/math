# 元の選択台へ戻す
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in oso_nonempty_cases():
    sigma, rho, subset, rank, old_points, new_points, old_min, new_min = row
    assert oso_supports[sigma][old_min] == oso_selected(sigma, rank)
    count += 1
assert count > 0
print("selected_return:", count, "exact checks; PASS")
