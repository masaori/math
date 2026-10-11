# 対象ラベル: claim_selected_odd_orbit_skew_product_neg
# 負の一との積
# 式ペア: (-1)\prod_{j\in C}A_{j,\sigma(j)}=-\prod_{j\in C}A_{j,\sigma(j)}
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for r in sop_matrix_rows:
    expr1 = sop_constant(-1) * sop_product(r['A'], r['subset'], r['sigma'])
    expr2 = -sop_product(r['A'], r['subset'], r['sigma'])
    assert expr1 == expr2, (r, expr1, expr2)
    count += 1
sop_record("inside_negative_one", count)
