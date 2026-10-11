# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 反転置換の略記
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_odd_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    k = row["k"]
    assert oso_reverse(sigma,row["subset"]) == row["tau"]
    count += 1
sfn_record("selected_reversal_name", count)
