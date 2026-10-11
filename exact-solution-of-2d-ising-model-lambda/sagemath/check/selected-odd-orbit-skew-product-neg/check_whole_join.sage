# 対象ラベル: claim_selected_odd_orbit_skew_product_neg
# 分離した積を全体へ戻す
# 式ペア: -(P_\sigma Q_\sigma)=-\prod_{i\in\mathcal J}A_{i,\sigma(i)}
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for r in sop_matrix_rows:
    expr1 = -(r['P_sigma'] * r['Q_sigma'])
    expr2 = -r['all_sigma']
    assert expr1 == expr2, (r, expr1, expr2)
    count += 1
sop_record("whole_join", count)
