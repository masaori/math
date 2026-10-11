# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 選んだ最小元の奇数点への所属
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_odd_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    k = row["k"]
    assert a in row["points"]
    count += 1
sfn_record("minimum_odd", count)
