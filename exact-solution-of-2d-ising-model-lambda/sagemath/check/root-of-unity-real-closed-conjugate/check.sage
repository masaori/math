R = PolynomialRing(QQ, names=('a', 'b', 'c', 'd'))
a, b, c, d = R.gens()
S = R['w'].quotient(R['w'].gen()^2 + 1, 'w')
w = S.gen()
z = S(a + b*w)
t = S(c + d*w)
conj = lambda x: S(x.lift()[0] - x.lift()[1]*w)
assert conj(z + t) == conj(z) + conj(t)
assert conj(z*t) == conj(z)*conj(t)
assert conj(conj(z)) == z
assert z*conj(z) == S(a^2 + b^2)
for n in range(1, 13):
    for k in range(n):
        root = QQbar.zeta(n)^k
        assert root*root.conjugate() == 1
        assert root^(-1) == root.conjugate()
print('RESULT: PASS root of unity real-closed conjugate')
