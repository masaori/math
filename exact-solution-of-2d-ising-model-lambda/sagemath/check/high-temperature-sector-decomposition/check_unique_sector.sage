# 対象ラベル: claim_high_temperature_sector_decomposition
# 式ペア: Even_L(A) implies there exists exactly one (a,b) with A in E_L^{a,b}
# 帰属: 有限集合、ZZ[x]。浮動小数点を使わない。

load('sagemath/check/high-temperature-sector-decomposition/construction.sage')

checked = 0
for L, even_subsets, weights, winding_fibers, sector_members, high_polynomial, sector_polynomials in high_sector_samples():
    for subset in even_subsets:
        assert sum(ZZ(subset in members) for members in sector_members.values()) == 1
        checked += 1
assert checked == 1060
print('check_unique_sector.sage: RESULT: PASS (%d 例)' % checked)
