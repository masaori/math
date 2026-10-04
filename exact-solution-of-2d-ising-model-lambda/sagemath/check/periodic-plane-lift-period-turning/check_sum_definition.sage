# 対象ラベル: claim_periodic_plane_lift_period_turning
# 帰属: 有限集合と任意精度の整数。浮動小数点は使わない。
if '_period_turning_rows' not in globals():
    load('sagemath/check/periodic-plane-lift-period-turning/_prelude.sage')
# 式ペア: 循環隣接和の定義
checked = 0
for row in _period_turning_rows:
    m, L, P, B, D, edges, k, u = (row[name] for name in ('m', 'L', 'P', 'B', 'D', 'edges', 'k', 'u'))
    lift = lambda h: pt_lift(P, B, h)
    assert (pt_cyclic_weight(u)) == (sum(pt_weight(u[j],u[j+1]) for j in range(m-1)) + pt_weight(u[m-1],u[0]))
    checked += 1
assert checked > 0
print('check_sum_definition.sage: PASS (%d)' % checked)
