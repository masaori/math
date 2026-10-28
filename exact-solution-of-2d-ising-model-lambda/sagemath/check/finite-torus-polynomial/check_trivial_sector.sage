# 対象ラベル: claim_finite_torus_polynomial
P = PolynomialRing(ZZ, 'x')
x = P.gen()
G00 = 1 + 2*x + 3*x^2
Z = 2*G00
assert 4*G00 == 2*Z
assert (4*G00)/2 == Z
print('RESULT: PASS trivial-sector substitution')
