# 対象ラベル: claim_low_temperature_trivial_sector_expression
# 式ペア: 2 D_L = 2 sum_{B in B_L} x^{|B|}。帰属: ZZ[x]。
for _, attainable, _, _, low_temperature, _ in polynomial_rows:
    assert ZZ(2) * low_temperature == ZZ(2) * sum(
        (x ** ZZ(len(B)) for B in attainable), R.zero())
print('low_temperature_sum PASS', len(polynomial_rows))
