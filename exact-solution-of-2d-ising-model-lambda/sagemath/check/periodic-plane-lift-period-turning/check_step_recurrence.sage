# 対象ラベル: claim_periodic_plane_lift_period_turning
# 帰属: 有限集合と任意精度の整数。浮動小数点は使わない。
if '_period_turning_rows' not in globals():
    load('sagemath/check/periodic-plane-lift-period-turning/_prelude.sage')
# 式ペア: 持ち上げの有限漸化式
checked = 0
for row in _period_turning_rows:
    m, L, P, B, D, edges, k, u = (row[name] for name in ('m', 'L', 'P', 'B', 'D', 'edges', 'k', 'u'))
    lift = lambda h: pt_lift(P, B, h)
    for j in range(m):
        h = k+j
        q, r = divmod(h, m)
        assert pt_sub(P[r+1], P[r]) == pt_sub(pt_add(P[r], pt_displacement(L, edges[r])), P[r])
        checked += 1
assert checked > 0
print('check_step_recurrence.sage: PASS (%d)' % checked)
