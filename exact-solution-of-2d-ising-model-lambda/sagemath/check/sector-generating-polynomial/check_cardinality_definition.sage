# 対象ラベル: claim_low_temperature_trivial_sector_expression
# 式ペア: |Delta_L(B)| = |delta_L(B)|
for L, B in subset_rows:
    assert ZZ(len(delta_restriction(L, B))) == ZZ(len(dual_image(L, B)))
print('cardinality_definition PASS', len(subset_rows))
