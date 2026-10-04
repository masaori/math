# 対象ラベル: claim_low_temperature_trivial_sector_expression
# 式ペア: delta_L^{-1}(delta_L(B)) = delta_L^{-1}(delta_L(B'))
# 条件: delta_L(B) = delta_L(B')。始域の全ての組から条件を満たす組を取る。
for L, B, other in equal_image_rows:
    assert inverse_dual_image(L, dual_image(L, B)) == inverse_dual_image(
        L, dual_image(L, other))
print('inverse_substitution PASS', len(equal_image_rows))
