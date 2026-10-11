# 対象ラベル: claim_selected_odd_orbit_reversal_involution
# 選ぶ軌道の台の保存
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sor_rows:
    sigma, tau = row["sigma"], row["tau"]
    left = row["next_subset"]
    right = row["subset"]
    assert left == right
    count += 1
assert count > 0
print("selected_support:", count, "exact checks; PASS")
