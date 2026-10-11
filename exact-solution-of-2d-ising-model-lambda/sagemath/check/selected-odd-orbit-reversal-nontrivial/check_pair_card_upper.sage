# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 相異なる二点の個数の再使用
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_two_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    assert len(frozenset((a,b))) == 2
    count += 1
sfn_record("pair_card_upper", count)
