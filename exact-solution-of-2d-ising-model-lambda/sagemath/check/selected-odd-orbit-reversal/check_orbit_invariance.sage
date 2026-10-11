# 対象ラベル: def_selected_odd_orbit_reversal
# 軌道の台の不変性
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row, i in sor_point_cases(None):
    sigma, tau = row["sigma"], row["tau"]
    left = sigma[i] in sor_supports[sigma][row["minimum"]]
    right = i in sor_supports[sigma][row["minimum"]]
    assert left == right
    count += 1
assert count > 0
print("orbit_invariance:", count, "exact checks; PASS")
