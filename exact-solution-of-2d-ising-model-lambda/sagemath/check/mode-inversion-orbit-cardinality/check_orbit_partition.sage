# 対象ラベル: claim_mode_inversion_orbit_cardinality
# 軌道の分割、元数、各軌道での分散因子の一定性を QQbar で検算する。
for length in range(1, 5):
    for a in (0, 1):
        for b in (0, 1):
            points, orbits = orbit_factors(length, a, b)
            assert set().union(*map(set, orbits)) == points
            assert sum(len(group) for group in orbits) == len(points)
            for group in orbits:
                assert len(group) in (1, 2, 4)
                factor = delta(*next(iter(group)))
                assert all(delta(*point) == factor for point in group)
                assert (len(group) == 1) == all(value in (1, -1) for value in next(iter(group)))
