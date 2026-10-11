# 対象ラベル: def_selected_odd_orbit_reversal
# 選ぶ台の定義（像の所属）
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row, i in sor_point_cases(None):
    sigma, tau = row["sigma"], row["tau"]
    left = sigma[i] in row["subset"]
    right = sigma[i] in sor_supports[sigma][row["minimum"]]
    assert left == right
    count += 1
assert count > 0
print("support_definition_forward:", count, "exact checks; PASS")
