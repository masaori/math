# 対象ラベル: claim_signed_even_subgraph_rational_sign
# 積の符号の合成の段: 正の元の積の三行、P(q) = (1,1) の因子 · P'、
# -P^{0,0}(q) = (q^2+2q-1)·P'、有理数の符号の反映（-r の平方の証人が r <_R 0 を与えること）。
load(os.path.join(directory, '../signed-even-subgraph-orbit-product/_prelude.sage'))

S.<u, v, s, t> = PolynomialRing(QQ)
# u·v − 0 = (u−0)(v−0) = (s·s)(t·t) = (s·t)(s·t)（u−0 = s·s、v−0 = t·t を代入）
assert u*v - 0 == (u - 0)*(v - 0)
assert ((u - 0)*(v - 0)).subs({u: s*s, v: t*t}) == (s*s)*(t*t)
assert (s*s)*(t*t) == (s*t)*(s*t)
# 0 − r = (−r) − 0
T.<r> = PolynomialRing(QQ)
assert 0 - r == (-r) - 0

for length in range(1, 4):
    for a, b in ((0, 0), (0, 1), (1, 0), (1, 1)):
        points, orbits, factors, fixed, paired, quadrupled = orbit_products(length, a, b)
        one_one = [point for point in fixed if point == (1, 1)]
        rest = [fixed_factor(point) for point in fixed if point != (1, 1)]
        rest += [delta(*point) for point in paired]
        rest += [delta(*point)^2 for point in quadrupled]
        for q in (QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(3)/4, QQ(9)/10):
            c = q^2 + 2*q - 1
            P = prod(factors, R.one())(q)
            Prest = prod(rest, R.one())(q)
            assert Prest.imag() == 0 and Prest.real() > 0
            if (a, b) == (0, 0):
                assert len(one_one) == 1
                assert P == -c * Prest
                assert -P == c * Prest
            else:
                assert len(one_one) == 0
                assert P == Prest
print('check_sign_composition: PASS')
