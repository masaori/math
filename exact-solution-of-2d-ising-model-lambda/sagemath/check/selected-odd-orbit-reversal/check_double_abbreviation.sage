# 対象ラベル: claim_selected_odd_orbit_reversal_involution
# 選ぶ台の略記を戻す
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sor_domain_cases():
    sigma, tau = row["sigma"], row["tau"]
    left = oso_reverse(tau, oso_selected(sigma, row["rank"]))
    right = oso_reverse(tau, row["subset"])
    assert left == right
    count += 1
assert count > 0
print("double_abbreviation:", count, "exact checks; PASS")
