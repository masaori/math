# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 包含から台の個数の下界
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_local_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    assert len(frozenset((a,b))) <= len(row["subset"])
    count += 1
sfn_record("card_lower", count)
