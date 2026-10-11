# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 選んだ軌道の反転の定義
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_odd_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    k = row["k"]
    assert sor_reversal(sigma,row["rank"]) == oso_reverse(sigma,oso_selected(sigma,row["rank"]))
    count += 1
sfn_record("selected_reversal_definition", count)
