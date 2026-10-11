# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 逆方向の到達の所属
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row, n in ((r,n) for r in sfn_two_rows for n in range(2*len(r["sigma"])+2)):
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    assert sfn_iterate(inverse,n,a) in (a,b)
    count += 1
sfn_record("backward_iteration_membership", count)
