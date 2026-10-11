# 対象ラベル: claim_selected_odd_orbit_skew_product_neg
# 選んだ始点の軌道長の奇数性
# 式ペア: \operatorname{len}_{\sigma}(m)\text{ は奇数}
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for r in sop_rows:
    expr1 = ZZ(len(r['supports'][r['start']])) % 2 == 1
    expr2 = True
    assert expr1 == expr2, (r, expr1, expr2)
    count += 1
sop_record("selected_length_odd", count)
