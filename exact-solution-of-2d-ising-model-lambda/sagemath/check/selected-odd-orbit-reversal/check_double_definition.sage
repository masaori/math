# 対象ラベル: claim_selected_odd_orbit_reversal_involution
# 二回目の反転の定義
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sor_domain_cases():
    sigma, tau = row["sigma"], row["tau"]
    left = sor_reversal(tau, row["rank"])
    right = oso_reverse(tau, row["next_subset"])
    assert left == right
    count += 1
assert count > 0
print("double_definition:", count, "exact checks; PASS")
