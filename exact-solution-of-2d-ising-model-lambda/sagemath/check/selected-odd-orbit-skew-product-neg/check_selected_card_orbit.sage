# 対象ラベル: claim_selected_odd_orbit_skew_product_neg
# 選んだ台の定義による個数の置換
# 式ペア: |C|=|\operatorname{Orb}_{\sigma}(m)|
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for r in sop_rows:
    expr1 = ZZ(len(r['subset']))
    expr2 = ZZ(len(sop_orbit(r['sigma'], r['start'])))
    assert expr1 == expr2, (r, expr1, expr2)
    count += 1
sop_record("selected_card_orbit", count)
