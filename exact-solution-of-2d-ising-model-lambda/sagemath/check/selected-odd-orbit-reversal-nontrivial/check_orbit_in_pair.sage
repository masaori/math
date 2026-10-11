# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 軌道の台の二点への包含
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_two_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    assert row["subset"] <= frozenset((a,b))
    count += 1
sfn_record("orbit_in_pair", count)
