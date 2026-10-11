# 対象ラベル: claim_selected_odd_orbit_skew_product_neg
# 元の定数係数の定義へ戻す
# 式ペア: \widehat{\iota_{\mathbb Z}(\operatorname{sgn}(\sigma))}=c_\sigma
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for r in sop_rows:
    expr1 = sop_constant(sop_sign(r['sigma'], r['rank']))
    expr2 = r['c_sigma']
    assert expr1 == expr2, (r, expr1, expr2)
    count += 1
sop_record("coefficient_sigma_definition", count)
