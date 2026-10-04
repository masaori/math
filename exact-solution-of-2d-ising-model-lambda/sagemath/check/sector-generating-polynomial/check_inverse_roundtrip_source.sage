# 対象ラベル: claim_low_temperature_trivial_sector_expression
# 式ペア: B = delta_L^{-1}(delta_L(B))
for L, B in subset_rows:
    assert B == inverse_dual_image(L, dual_image(L, B))
print('inverse_roundtrip_source PASS', len(subset_rows))
