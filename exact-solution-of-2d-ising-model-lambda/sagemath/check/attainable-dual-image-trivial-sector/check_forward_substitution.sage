# 対象ラベル: claim_attainable_dual_image_trivial_sector
for L, sigma, B, A_sigma, attainable, trivial_sector in forward_rows:
    assert frozenset(dual_edge(L, e) for e in B) == frozenset(dual_edge(L, e) for e in broken_edge_set(L, sigma))
print('forward_substitution PASS', len(forward_rows))
