# 対象ラベル: claim_selected_odd_orbit_skew_product_neg
# 軌道内の反転の定義
# 式ペア: \prod_{i\in C}A_{i,\tau(i)}=\prod_{i\in C}A_{i,\sigma^{-1}(i)}
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for r in sop_matrix_rows:
    expr1 = sop_product(r['A'], r['subset'], r['tau'])
    expr2 = sop_product(r['A'], r['subset'], r['inverse'])
    assert expr1 == expr2, (r, expr1, expr2)
    count += 1
sop_record("inside_reversal_definition", count)
