# 対象ラベル: claim_selected_odd_orbit_skew_product_neg
# 不変条件を逆像へ適用
# 式ペア: \sigma^{-1}(i)\in C\Longleftrightarrow\sigma(\sigma^{-1}(i))\in C
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for r, i in sop_points():
    expr1 = r['inverse'][i] in r['subset']
    expr2 = r['sigma'][r['inverse'][i]] in r['subset']
    assert expr1 == expr2, (r, expr1, expr2)
    count += 1
sop_record("inverse_invariance", count)
