# 対象ラベル: claim_signed_even_subgraph_orbit_product
# Delta_O^{|O|} を軌道の各元の分散因子の積へ置換する。
for length in range(1, 5):
    for a in (0, 1):
        for b in (0, 1):
            points, orbits, factors, fixed, paired, quadrupled = orbit_products(length, a, b)
            powers = (prod(delta(*point) for point in fixed)
                      * prod(delta(*point)^2 for point in paired)
                      * prod(delta(*point)^4 for point in quadrupled))
            assert all(all(delta(*point) == delta(*next(iter(group))) for point in group)
                       for group in orbits)
            assert powers == prod(prod(delta(*point) for point in group) for group in orbits)
