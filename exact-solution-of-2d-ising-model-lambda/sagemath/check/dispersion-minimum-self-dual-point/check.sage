from sage.all import QQ, QQbar, PolynomialRing

P = PolynomialRing(QQ, names=('r', 'c1', 'c2'))
r, c1, c2 = P.gens()
B = (1+r^2)^2 - 2*r*(1-r^2)*(c1+c2)
gap = (1-2*r-r^2)^2
assert B-gap == 2*r*(1-r^2)*((1-c1)+(1-c2))
assert B(c1=1, c2=1) == gap
assert gap == (r^2+2*r-1)^2

xc = QQbar(2).sqrt() - 1
assert 0 < xc < 1
assert xc^2 + 2*xc - 1 == 0
assert gap(r=xc) == 0
assert (1-xc)/(1+xc) == xc
print('PASS: 分散式の最小値と自己双対点')
