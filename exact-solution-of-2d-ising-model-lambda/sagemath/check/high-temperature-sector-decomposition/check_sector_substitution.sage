# 対象ラベル: claim_high_temperature_sector_decomposition
# 式ペア: sum_{A even, epsilon_h(A)=a,epsilon_v(A)=b} weight(A) = sum_{A in E_L^{a,b}} weight(A)
# 帰属: 有限集合、ZZ[x]。浮動小数点を使わない。

load('sagemath/check/high-temperature-sector-decomposition/construction.sage')

checked = 0
for L, even_subsets, weights, winding_fibers, sector_members, high_polynomial, sector_polynomials in high_sector_samples():
    for key in winding_fibers:
        assert frozenset(winding_fibers[key]) == frozenset(sector_members[key])
        left = sum((weights[subset] for subset in winding_fibers[key]), PolynomialRingZx(0))
        right = sum((weights[subset] for subset in sector_members[key]), PolynomialRingZx(0))
        assert left == right
        checked += 1
assert checked == 12
print('check_sector_substitution.sage: RESULT: PASS (%d 例)' % checked)
