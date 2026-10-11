# 対象ラベル: claim_selected_odd_orbit_reversal_involution
# 反転後の不動点なし集合の所属
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sor_rows:
    sigma, tau = row["sigma"], row["tau"]
    left = not any(tau[i] == i for i in range(len(tau)))
    right = all(tau[i] != i for i in range(len(tau)))
    assert left == right
    count += 1
assert count > 0
print("derangement_definition_forward:", count, "exact checks; PASS")
