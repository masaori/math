# 対象ラベル: claim_attainable_dual_image_trivial_sector
for L, sigma, B, A_sigma, attainable, trivial_sector in forward_rows:
    assert A_sigma in trivial_sector
print('forward_sector PASS', len(forward_rows))
