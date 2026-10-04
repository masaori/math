# 対象ラベル: claim_low_temperature_trivial_sector_expression
# 式ペア: {delta_L(B) | B in B_L} = E_L^{0,0}
for L, attainable, trivial_sector, _, _, _ in polynomial_rows:
    assert {dual_image(L, B) for B in attainable} == trivial_sector
print('image_trivial_sector PASS', len(polynomial_rows))
