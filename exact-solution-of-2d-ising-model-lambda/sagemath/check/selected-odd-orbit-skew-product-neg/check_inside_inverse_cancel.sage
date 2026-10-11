# 対象ラベル: claim_selected_odd_orbit_skew_product_neg
# 再添字付けした成分の逆写像の相殺
# 式ペア: \prod_{j\in C}A_{\sigma(j),\sigma^{-1}(\sigma(j))}=\prod_{j\in C}A_{\sigma(j),j}
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for r in sop_matrix_rows:
    expr1 = sop_factor_product(r['A'][r['sigma'][j], r['inverse'][r['sigma'][j]]] for j in sorted(r['subset']))
    expr2 = sop_factor_product(r['A'][r['sigma'][j], j] for j in sorted(r['subset']))
    assert expr1 == expr2, (r, expr1, expr2)
    count += 1
sop_record("inside_inverse_cancel", count)
