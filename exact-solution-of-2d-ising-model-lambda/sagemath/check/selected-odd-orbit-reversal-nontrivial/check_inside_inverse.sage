# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 台の内側の反転の定義
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_local_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    assert inverse[a] == oso_reverse(sigma,row["subset"])[a]
    count += 1
sfn_record("inside_inverse", count)
