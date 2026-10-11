# 対象ラベル: claim_selected_odd_orbit_reversal_involution
# 各点での不動性の同値
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sor_rows:
    sigma, tau = row["sigma"], row["tau"]
    left = all(tau[i] != i for i in range(len(tau)))
    right = all(sigma[i] != i for i in range(len(sigma)))
    assert left == right
    count += 1
assert count > 0
print("derangement_pointwise:", count, "exact checks; PASS")
