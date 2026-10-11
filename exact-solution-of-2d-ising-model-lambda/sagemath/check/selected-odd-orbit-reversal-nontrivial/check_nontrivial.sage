# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 奇数軌道を選んだ反転の非自明性
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_odd_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    k = row["k"]
    assert row["tau"] != sigma
    count += 1
sfn_record("nontrivial", count)
