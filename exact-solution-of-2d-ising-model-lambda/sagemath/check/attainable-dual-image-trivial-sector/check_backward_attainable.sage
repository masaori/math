# 対象ラベル: claim_attainable_dual_image_trivial_sector
for L, A, sigma, B, attainable, dual_images in backward_rows:
    assert B in attainable
print('backward_attainable PASS', len(backward_rows))
