# 対象ラベル: claim_selected_odd_orbit_skew_product_neg
# 最小点の奇数点集合への所属
# 式ペア: m\in\operatorname{OddPts}(\sigma)
# 帰属: 有限集合・ZZ・Q(zeta_8)[x]。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for r in sop_rows:
    expr1 = r['start'] in r['odd_points']
    expr2 = True
    assert expr1 == expr2, (r, expr1, expr2)
    count += 1
sop_record("least_point_membership", count)
