# 対象ラベル: claim_attainable_dual_image_trivial_sector
for L, A, sigma, B, attainable, dual_images in backward_rows:
    assert frozenset(dual_edge(L, e) for e in broken_edge_set(L, sigma)) == A
print('backward_reconstruction PASS', len(backward_rows))
