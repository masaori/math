# 対象ラベル: claim_periodic_plane_lift_period_turning
# 帰属: 有限集合と任意精度の整数。浮動小数点は使わない。
if '_period_turning_rows' not in globals():
    load('sagemath/check/periodic-plane-lift-period-turning/_prelude.sage')
# 式ペア: 閉じ目を含めた t_circ(gamma) の定義
checked = 0
for row in _period_turning_rows:
    m, L, P, B, D, edges, k, u = (row[name] for name in ('m', 'L', 'P', 'B', 'D', 'edges', 'k', 'u'))
    lift = lambda h: pt_lift(P, B, h)
    assert (row['internal'] + pt_tau(L,edges[-1],edges[0])) == (row['turns'])
    checked += 1
assert checked > 0
print('check_sum_total_turn.sage: PASS (%d)' % checked)
