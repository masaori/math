# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 帰納法の始点の零回
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row, f, n in sfn_iteration_rows():
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    assert sfn_iterate(f, 0, a) == a
    count += 1
sfn_record("iteration_base_start", count)
