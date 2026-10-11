# 対象ラベル: claim_selected_odd_orbit_skew_product_neg
# 符号付き項に係数の等号を代入
# 式ペア: c_\tau\prod_i A_{i,\tau(i)}=c_\sigma\prod_i A_{i,\tau(i)}
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for r in sop_matrix_rows:
    expr1 = r['c_tau'] * r['all_tau']
    expr2 = r['c_sigma'] * r['all_tau']
    assert expr1 == expr2, (r, expr1, expr2)
    count += 1
sop_record("signed_coefficient_substitution", count)
