# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 始点の一歩を隣点へ替える
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row, f, n in sfn_iteration_rows():
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    assert sfn_iterate(f,n,f[a]) == sfn_iterate(f,n,b)
    count += 1
sfn_record("iteration_start_swap", count)
