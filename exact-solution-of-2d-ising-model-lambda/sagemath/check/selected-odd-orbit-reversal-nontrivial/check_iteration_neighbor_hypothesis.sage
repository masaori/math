# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 隣点からの反復の所属
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row, f, n in sfn_iteration_rows():
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    assert sfn_iterate(f,n,b) in (a,b)
    count += 1
sfn_record("iteration_neighbor_hypothesis", count)
