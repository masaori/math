# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 相異なる二点の個数
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_local_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    assert 2 == len(frozenset((a,b)))
    count += 1
sfn_record("pair_card_lower", count)
