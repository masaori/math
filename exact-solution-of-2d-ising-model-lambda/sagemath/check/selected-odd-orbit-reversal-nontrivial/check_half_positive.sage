# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 二以上の奇数の半分の自然数の下界
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_odd_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    k = row["k"]
    assert 1 <= k
    count += 1
sfn_record("half_positive", count)
