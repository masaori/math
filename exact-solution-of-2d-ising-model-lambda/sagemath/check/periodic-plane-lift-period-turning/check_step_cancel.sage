# 対象ラベル: claim_periodic_plane_lift_period_turning
# 帰属: 有限集合と任意精度の整数。浮動小数点は使わない。
if '_period_turning_rows' not in globals():
    load('sagemath/check/periodic-plane-lift-period-turning/_prelude.sage')
# 式ペア: 共通の qB の消去
checked = 0
for row in _period_turning_rows:
    m, L, P, B, D, edges, k, u = (row[name] for name in ('m', 'L', 'P', 'B', 'D', 'edges', 'k', 'u'))
    lift = lambda h: pt_lift(P, B, h)
    for j in range(m):
        h = k+j
        q, r = divmod(h, m)
        assert pt_sub(pt_add(lift(r+1), pt_scale(q,B)), pt_add(lift(r), pt_scale(q,B))) == pt_sub(lift(r+1), lift(r))
        checked += 1
assert checked > 0
print('check_step_cancel.sage: PASS (%d)' % checked)
