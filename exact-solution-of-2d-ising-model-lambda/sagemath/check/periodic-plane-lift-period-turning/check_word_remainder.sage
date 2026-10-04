# 対象ラベル: claim_periodic_plane_lift_period_turning
# 帰属: 有限集合と任意精度の整数。浮動小数点は使わない。
if '_period_turning_rows' not in globals():
    load('sagemath/check/periodic-plane-lift-period-turning/_prelude.sage')
# 式ペア: 一歩の同定へ h=k+j を代入
checked = 0
for row in _period_turning_rows:
    m, L, P, B, D, edges, k, u = (row[name] for name in ('m', 'L', 'P', 'B', 'D', 'edges', 'k', 'u'))
    lift = lambda h: pt_lift(P, B, h)
    for j in range(m):
        assert pt_sub(lift(k+j+1), lift(k+j)) == D[(k+j) % m]
        checked += 1
assert checked > 0
print('check_word_remainder.sage: PASS (%d)' % checked)
