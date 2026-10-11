# 対象ラベル: claim_selected_odd_orbit_reversal_involution
# 同じ台での二重反転
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sor_domain_cases():
    sigma, tau = row["sigma"], row["tau"]
    left = oso_reverse(oso_reverse(sigma, row["subset"]), row["subset"])
    right = sigma
    assert left == right
    count += 1
assert count > 0
print("double_cancel:", count, "exact checks; PASS")
