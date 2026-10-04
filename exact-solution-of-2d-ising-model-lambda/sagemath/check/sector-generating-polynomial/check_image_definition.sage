# 対象ラベル: claim_low_temperature_trivial_sector_expression
# 式ペア: {Delta_L(B) | B in B_L} = {delta_L(B) | B in B_L}
for L, attainable, _, _, _, _ in polynomial_rows:
    assert {delta_restriction(L, B) for B in attainable} == {
        dual_image(L, B) for B in attainable}
print('image_definition PASS', len(polynomial_rows))
