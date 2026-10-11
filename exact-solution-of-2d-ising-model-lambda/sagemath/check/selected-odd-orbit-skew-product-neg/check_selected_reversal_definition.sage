# 対象ラベル: claim_selected_odd_orbit_skew_product_neg
# 選んだ奇数軌道の反転を不変部分集合上の反転へ展開
# 式ペア: \tau=\rho_C(\sigma)
# 帰属: 有限集合上の置換。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for r in sop_rows:
    expr1 = r['tau']
    expr2 = tuple(r['inverse'][i] if i in r['subset'] else r['sigma'][i]
                  for i in range(len(r['sigma'])))
    assert expr1 == expr2, (r, expr1, expr2)
    count += 1
sop_record("selected_reversal_definition", count)
