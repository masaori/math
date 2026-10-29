# 対象ラベル: claim_signed_even_subgraph_duality_sign
load(os.path.join(directory, '../signed-even-subgraph-orbit-product/_prelude.sage'))

xc = QQbar(2).sqrt() - 1
assert xc^2 + 2*xc - 1 == 0
assert 0 < xc < 1
assert (1 + xc)^2 == 2
assert (1 - xc)/(1 + xc) == xc

for length in range(1, 4):
    for a, b in ((0, 1), (1, 0), (1, 1)):
        points, orbits, factors, fixed, paired, quadrupled = orbit_products(length, a, b)
        assert (QQbar(1), QQbar(1)) not in points
        for varpi, varsigma in points:
            value = delta(varpi, varsigma)(xc)
            horizontal = 2 - varpi - varpi^(-1)
            vertical = 2 - varsigma - varsigma^(-1)
            assert value == (xc^2 + 2*xc - 1)^2 + xc*(1 - xc^2)*(horizontal + vertical)
            assert value == xc*(1 - xc^2)*(horizontal + vertical)
            assert value.imag() == 0 and value.real() > 0
        Q = prod(factors, R.one())
        D = prod((delta(*point) for point in points), R.one())
        assert Q(xc)^2 == D(xc) and Q(xc) != 0
