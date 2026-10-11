# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 選んだ台の略記
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_odd_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    k = row["k"]
    assert oso_reverse(sigma,oso_selected(sigma,row["rank"])) == oso_reverse(sigma,row["subset"])
    count += 1
sfn_record("selected_reversal_support", count)
