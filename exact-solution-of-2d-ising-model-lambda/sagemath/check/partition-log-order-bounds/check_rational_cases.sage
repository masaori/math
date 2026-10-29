R = PolynomialRing(QQ, 'q')
q = R.gen()
assert not (q**2 + 2*q - 1).roots()
print('PASS: rational point cannot satisfy the self-dual quadratic')
