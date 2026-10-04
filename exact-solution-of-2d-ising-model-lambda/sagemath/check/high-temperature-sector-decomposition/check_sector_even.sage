# 対象ラベル: claim_high_temperature_sector_decomposition
# 式ペア: A in E_L^{a,b} implies Even_L(A)
# 帰属: 有限集合、ZZ[x]。浮動小数点を使わない。

load('sagemath/check/high-temperature-sector-decomposition/construction.sage')

checked = 0
for L, even_subsets, weights, winding_fibers, sector_members, high_polynomial, sector_polynomials in high_sector_samples():
    for members in sector_members.values():
        for subset in members:
            assert all(sum(ZZ(endpoint == vertex) for edge in subset
                           for endpoint in endpoints(L, edge)) % 2 == 0
                       for vertex in vertices(L))
            checked += 1
assert checked == 1060
print('check_sector_even.sage: RESULT: PASS (%d 例)' % checked)
