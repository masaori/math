# 対象ラベル: claim_selected_odd_orbit_skew_product_neg
# 制限写像の左逆性
# 式ペア: \sigma^{-1}(\sigma(i))=i
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for r, i in sop_points(inside=True):
    expr1 = r['inverse'][r['sigma'][i]]
    expr2 = i
    assert expr1 == expr2, (r, expr1, expr2)
    count += 1
sop_record("restricted_left_inverse", count)
