# 対象ラベル: claim_high_temperature_sector_decomposition
# 式ペア: sum_{A even} weight(A) = sum_{(a,b)} sum_{A even, epsilon_h(A)=a,epsilon_v(A)=b} weight(A)
# 帰属: 有限集合、ZZ[x]。浮動小数点を使わない。

load('sagemath/check/high-temperature-sector-decomposition/construction.sage')

checked = 0
for L, even_subsets, weights, winding_fibers, sector_members, high_polynomial, sector_polynomials in high_sector_samples():
    left = sum((weights[subset] for subset in even_subsets), PolynomialRingZx(0))
    right = sum((sum((weights[subset] for subset in members), PolynomialRingZx(0))
                 for members in winding_fibers.values()), PolynomialRingZx(0))
    assert left == right
    checked += 1
assert checked == 3
print('check_partition_sum.sage: RESULT: PASS (%d 例)' % checked)
