# 対象ラベル: claim_selected_odd_orbit_reversal_involution
# 奇数点の集合の保存
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sor_rows:
    sigma, tau = row["sigma"], row["tau"]
    left = row["next_points"]
    right = row["points"]
    assert left == right
    count += 1
assert count > 0
print("odd_points:", count, "exact checks; PASS")
