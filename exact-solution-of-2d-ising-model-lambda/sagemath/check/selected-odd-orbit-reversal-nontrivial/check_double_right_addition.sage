# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 半分の下界の右への加法
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_odd_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    k = row["k"]
    assert k+k >= 1+k
    count += 1
sfn_record("double_right_addition", count)
