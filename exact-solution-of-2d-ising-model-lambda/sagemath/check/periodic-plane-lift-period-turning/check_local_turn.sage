# 対象ラベル: claim_periodic_plane_lift_period_turning
# 帰属: 有限集合と任意精度の整数。浮動小数点は使わない。
if '_period_turning_rows' not in globals():
    load('sagemath/check/periodic-plane-lift-period-turning/_prelude.sage')
# 式ペア: theta(D_j,D_(rho_1(j))) = tau(e_(j+1),e_(rho_1(j)+1))
checked = 0
for row in _period_turning_rows:
    m, L, P, B, D, edges, k, u = (row[name] for name in ('m', 'L', 'P', 'B', 'D', 'edges', 'k', 'u'))
    lift = lambda h: pt_lift(P, B, h)
    for j in range(m):
        assert pt_weight(D[j],D[pt_rho(1,j,m)]) == pt_tau(L,edges[j],edges[pt_rho(1,j,m)])
        checked += 1
assert checked > 0
print('check_local_turn.sage: PASS (%d)' % checked)
