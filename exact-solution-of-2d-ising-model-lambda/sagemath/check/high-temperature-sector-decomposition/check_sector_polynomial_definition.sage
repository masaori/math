# 対象ラベル: claim_high_temperature_sector_decomposition
# 式ペア: sum_{A in E_L^{a,b}} weight(A) = H_L^{a,b}
# 帰属: 有限集合、ZZ[x]。浮動小数点を使わない。

load('sagemath/check/high-temperature-sector-decomposition/construction.sage')

checked = 0
for L, even_subsets, weights, winding_fibers, sector_members, high_polynomial, sector_polynomials in high_sector_samples():
    for key in sector_members:
        left = sum((weights[subset] for subset in sector_members[key]), PolynomialRingZx(0))
        assert left == sector_polynomials[key]
        checked += 1
assert checked == 12
print('check_sector_polynomial_definition.sage: RESULT: PASS (%d 例)' % checked)
