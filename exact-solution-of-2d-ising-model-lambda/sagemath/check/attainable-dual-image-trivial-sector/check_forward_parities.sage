# 対象ラベル: claim_attainable_dual_image_trivial_sector
for L, sigma, B, A_sigma, attainable, trivial_sector in forward_rows:
    assert winding_sector(L, A_sigma) == (0, 0)
print('forward_parities PASS', len(forward_rows))
