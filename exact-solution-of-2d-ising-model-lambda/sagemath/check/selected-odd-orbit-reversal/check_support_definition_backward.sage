# 対象ラベル: def_selected_odd_orbit_reversal
# 選ぶ台の定義（元の所属）
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row, i in sor_point_cases(None):
    sigma, tau = row["sigma"], row["tau"]
    left = i in sor_supports[sigma][row["minimum"]]
    right = i in row["subset"]
    assert left == right
    count += 1
assert count > 0
print("support_definition_backward:", count, "exact checks; PASS")
