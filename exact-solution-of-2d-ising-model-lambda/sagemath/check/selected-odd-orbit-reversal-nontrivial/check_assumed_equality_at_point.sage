# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 反転が元と一致する仮定の点での評価
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_two_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    assert row["tau"][a] == sigma[a]
    count += 1
sfn_record("assumed_equality_at_point", count)
