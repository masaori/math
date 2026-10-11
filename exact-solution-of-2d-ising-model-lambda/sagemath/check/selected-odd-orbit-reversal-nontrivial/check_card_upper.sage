# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 包含から台の個数の上界
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_two_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    assert len(row["subset"]) <= len(frozenset((a,b)))
    count += 1
sfn_record("card_upper", count)
