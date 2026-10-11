# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 選んだ台の軌道としての定義
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_local_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    assert row["subset"] == sor_graph_supports(sigma)[a]
    count += 1
sfn_record("selected_support_definition", count)
