# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 反転の局所的な略記
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_local_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    assert oso_reverse(sigma,row["subset"])[a] == row["tau"][a]
    count += 1
sfn_record("reversal_point_name", count)
