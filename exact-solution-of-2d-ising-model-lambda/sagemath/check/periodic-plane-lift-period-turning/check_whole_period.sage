# 対象ラベル: claim_periodic_plane_lift_period_turning
# 帰属: 有限集合と任意精度の整数。浮動小数点は使わない。
if '_period_turning_rows' not in globals():
    load('sagemath/check/periodic-plane-lift-period-turning/_prelude.sage')

checked = 0
histogram = {}
nonzero_winding_and_turn = 0
for row in _period_turning_rows:
    L, m, P, B, D, edges, points, u = (row[name] for name in ('L','m','P','B','D','edges','points','u'))
    assert P[-1] == pt_add(P[0], B)
    assert all(pt_displacement(L,edges[j]) == D[j] for j in range(m))
    projected = tuple(pt_project(L,points[j],u[j]) for j in range(m))
    original_turn = sum(pt_tau(L,edges[j],edges[(j+1)%m]) for j in range(m))
    projected_turn = sum(pt_tau(L,projected[j],projected[(j+1)%m]) for j in range(m))
    assert pt_cyclic_weight(u) == original_turn == projected_turn
    histogram[original_turn] = histogram.get(original_turn,0)+1
    if B != (0,0) and original_turn != 0:
        nonzero_winding_and_turn += 1
    checked += 1
assert nonzero_winding_and_turn > 0
assert any(x < 0 for x in histogram) and any(x > 0 for x in histogram)
print('check_whole_period.sage: PASS (%d periods, turns=%s, nonzero winding and turn=%d)' %
      (checked, sorted(histogram.items()), nonzero_winding_and_turn))
