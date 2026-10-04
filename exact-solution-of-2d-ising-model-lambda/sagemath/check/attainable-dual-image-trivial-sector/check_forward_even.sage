# 対象ラベル: claim_attainable_dual_image_trivial_sector
for L, sigma, B, A_sigma, attainable, trivial_sector in forward_rows:
    assert is_even_subgraph(L, A_sigma)
print('forward_even PASS', len(forward_rows))
