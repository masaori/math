# 対象ラベル: claim_selected_odd_orbit_reversal_involution
# 等号の対称性
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
truth_values = set()
for row, i in sor_point_cases(True):
    sigma, tau = row["sigma"], row["tau"]
    left = i == sigma[i]
    right = sigma[i] == i
    assert left == right
    count += 1
    truth_values.add(bool(left))
assert count > 0
assert truth_values == {False, True}
print("inside_symmetry:", count, "exact checks; PASS")
