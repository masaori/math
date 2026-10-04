# 対象ラベル: claim_low_temperature_trivial_sector_expression
# 式ペア: Z_L = 2 D_L。帰属: ZZ[x]。
for _, _, _, partition, low_temperature, _ in polynomial_rows:
    assert partition == ZZ(2) * low_temperature
print('partition_low_temperature PASS', len(polynomial_rows))
