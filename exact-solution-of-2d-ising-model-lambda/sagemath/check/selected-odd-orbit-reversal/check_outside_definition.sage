# 対象ラベル: claim_selected_odd_orbit_reversal_involution
# 外側の反転の定義
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
truth_values = set()
for row, i in sor_point_cases(False):
    sigma, tau = row["sigma"], row["tau"]
    left = tau[i] == i
    right = sigma[i] == i
    assert left == right
    count += 1
    truth_values.add(bool(left))
assert count > 0
assert truth_values == {False, True}
print("outside_definition:", count, "exact checks; PASS")
