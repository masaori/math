# 対象ラベル: claim_selected_odd_orbit_skew_product_neg
# 順逆相殺による所属の同値
# 式ペア: \sigma(\sigma^{-1}(i))\in C\Longleftrightarrow i\in C
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for r, i in sop_points():
    expr1 = r['sigma'][r['inverse'][i]] in r['subset']
    expr2 = i in r['subset']
    assert expr1 == expr2, (r, expr1, expr2)
    count += 1
sop_record("inverse_cancel_membership", count)
