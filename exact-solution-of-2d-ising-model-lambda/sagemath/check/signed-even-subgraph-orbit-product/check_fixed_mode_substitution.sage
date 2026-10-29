# 対象ラベル: claim_signed_even_subgraph_orbit_product
# 一元軌道の F_O^2 を分散因子 Delta_O に置換する。
for length in range(1, 5):
    for a in (0, 1):
        for b in (0, 1):
            points, orbits, factors, fixed, paired, quadrupled = orbit_products(length, a, b)
            assert all(fixed_factor(point)^2 == delta(*point) for point in fixed)
            assert prod(factor^2 for factor in factors) == (
                prod(delta(*point) for point in fixed)
                * prod(delta(*point)^2 for point in paired)
                * prod(delta(*point)^4 for point in quadrupled))
