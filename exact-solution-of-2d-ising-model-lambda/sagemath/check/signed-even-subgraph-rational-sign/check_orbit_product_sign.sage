# 対象ラベル: claim_signed_even_subgraph_rational_sign
load(os.path.join(directory, '../signed-even-subgraph-orbit-product/_prelude.sage'))

for length in range(1, 4):
    for a, b in ((0, 0), (0, 1), (1, 0), (1, 1)):
        points, orbits, factors, fixed, paired, quadrupled = orbit_products(length, a, b)
        assert ((QQbar(1), QQbar(1)) in points) == ((a, b) == (0, 0))
        assert sum(1 for point in fixed if point == (1, 1)) == int((a, b) == (0, 0))
        for q in (QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(3)/4, QQ(9)/10):
            for point in paired + quadrupled:
                value = delta(*point)(q)
                assert value.imag() == 0 and value.real() > 0
            Q = prod(factors, R.one())
            value = Q(q)
            assert value.imag() == 0 and value.real() != 0
            expected = -1 if (a, b) == (0, 0) and q^2 + 2*q - 1 > 0 else 1
            assert value.real() * expected > 0
