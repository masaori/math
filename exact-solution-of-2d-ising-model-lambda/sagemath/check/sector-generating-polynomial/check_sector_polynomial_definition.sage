# 対象ラベル: claim_low_temperature_trivial_sector_expression
# 式ペア: 2 sum_{A in E_L^{0,0}} x^{|A|} = 2 G_L^{0,0}。帰属: ZZ[x]。
for _, _, trivial_sector, _, _, generating in polynomial_rows:
    assert ZZ(2) * sum((x ** ZZ(len(A)) for A in trivial_sector), R.zero()) == ZZ(2) * generating
print('sector_polynomial_definition PASS', len(polynomial_rows))
