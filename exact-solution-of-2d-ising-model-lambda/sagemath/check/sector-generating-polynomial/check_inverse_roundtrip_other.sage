# 対象ラベル: claim_low_temperature_trivial_sector_expression
# 式ペア: delta_L^{-1}(delta_L(B')) = B'
for L, _, other in equal_image_rows:
    assert inverse_dual_image(L, dual_image(L, other)) == other
print('inverse_roundtrip_other PASS', len(equal_image_rows))
