# 対象ラベル: claim_selected_odd_orbit_reversal_involution
# 元の不動点なし集合の所属
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sor_rows:
    sigma, tau = row["sigma"], row["tau"]
    left = all(sigma[i] != i for i in range(len(sigma)))
    right = not any(sigma[i] == i for i in range(len(sigma)))
    assert left == right
    count += 1
assert count > 0
print("derangement_definition_backward:", count, "exact checks; PASS")
