# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 像の略記
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_local_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    assert sigma[a] == b
    count += 1
sfn_record("first_name", count)
