# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 始点への零回の反復
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_local_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    assert sfn_iterate(sigma, 0, a) == a
    count += 1
sfn_record("zero_iteration", count)
