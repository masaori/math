# 対象ラベル: claim_selected_odd_orbit_reversal_involution
# 二回目の台を一回目の台へ置換
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sor_domain_cases():
    sigma, tau = row["sigma"], row["tau"]
    left = oso_reverse(tau, row["next_subset"])
    right = oso_reverse(tau, oso_selected(sigma, row["rank"]))
    assert left == right
    count += 1
assert count > 0
print("double_support:", count, "exact checks; PASS")
