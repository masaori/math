# 対象ラベル: claim_low_temperature_trivial_sector_expression
# 式ペア: |delta_L(B)| = |B|
for L, B in subset_rows:
    assert ZZ(len(dual_image(L, B))) == ZZ(len(B))
print('cardinality_preservation PASS', len(subset_rows))
