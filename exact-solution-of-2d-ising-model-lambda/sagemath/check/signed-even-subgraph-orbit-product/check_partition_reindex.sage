# 対象ラベル: claim_signed_even_subgraph_orbit_product
# 軌道の分割による有限積の再添字付け。
for length in range(1, 5):
    for a in (0, 1):
        for b in (0, 1):
            points, orbits, factors, fixed, paired, quadrupled = orbit_products(length, a, b)
            assert set().union(*map(set, orbits)) == points
            assert sum(len(group) for group in orbits) == len(points)
            assert prod(prod(delta(*point) for point in group) for group in orbits) == prod(
                delta(*point) for point in points)
