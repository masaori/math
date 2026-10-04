# 対象ラベル: claim_high_temperature_sector_decomposition
# 式ペア: H_L = sum_{A even} (1+x)^(2L^2-|A|)(1-x)^|A|
# 帰属: 有限集合、ZZ[x]。浮動小数点を使わない。

load('sagemath/check/high-temperature-sector-decomposition/construction.sage')

checked = 0
for L, even_subsets, weights, winding_fibers, sector_members, high_polynomial, sector_polynomials in high_sector_samples():
    assert high_polynomial == sum(
        ((PolynomialRingZx(1) + x) ** (2 * L * L - len(subset)) *
         (PolynomialRingZx(1) - x) ** len(subset) for subset in even_subsets),
        PolynomialRingZx(0))
    checked += 1
assert checked == 3
print('check_high_temperature_definition.sage: RESULT: PASS (%d 例)' % checked)
