# 対象ラベル: claim_selected_odd_orbit_skew_product_neg
# 全体の積を内側と外側へ分離
# 式ペア: \prod_{i\in\mathcal J}A_{i,\tau(i)}=P_\tau Q_\tau
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for r in sop_matrix_rows:
    expr1 = r['all_tau']
    expr2 = r['P_tau'] * r['Q_tau']
    assert expr1 == expr2, (r, expr1, expr2)
    count += 1
sop_record("whole_split", count)
