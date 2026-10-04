# 対象ラベル: claim_high_temperature_sector_decomposition
# 式ペア: sum_{(a,b)} H_L^{a,b} = H_L^{0,0}+H_L^{0,1}+H_L^{1,0}+H_L^{1,1}
# 帰属: 有限集合、ZZ[x]。浮動小数点を使わない。

load('sagemath/check/high-temperature-sector-decomposition/construction.sage')

checked = 0
for L, even_subsets, weights, winding_fibers, sector_members, high_polynomial, sector_polynomials in high_sector_samples():
    left = sum(sector_polynomials.values(), PolynomialRingZx(0))
    right = (sector_polynomials[(0, 0)] + sector_polynomials[(0, 1)]
             + sector_polynomials[(1, 0)] + sector_polynomials[(1, 1)])
    assert left == right
    checked += 1
assert checked == 3
print('check_four_sector_sum.sage: RESULT: PASS (%d 例)' % checked)
