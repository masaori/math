# 対象ラベル: claim_selected_odd_orbit_skew_product_neg
# 外側の積の不変性を代入
# 式ペア: (-P_\sigma)Q_\tau=(-P_\sigma)Q_\sigma
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for r in sop_matrix_rows:
    expr1 = (-r['P_sigma']) * r['Q_tau']
    expr2 = (-r['P_sigma']) * r['Q_sigma']
    assert expr1 == expr2, (r, expr1, expr2)
    count += 1
sop_record("whole_outside_substitution", count)
