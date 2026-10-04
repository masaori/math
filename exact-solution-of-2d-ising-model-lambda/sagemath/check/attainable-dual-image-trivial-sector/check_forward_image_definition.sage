# 対象ラベル: claim_attainable_dual_image_trivial_sector
for L, sigma, B, A_sigma, attainable, trivial_sector in forward_rows:
    assert frozenset(dual_edge(L, e) for e in broken_edge_set(L, sigma)) == A_sigma
print('forward_image_definition PASS', len(forward_rows))
