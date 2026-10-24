# 帰属: ZZ / QQ / QQbar。有限標本と零表示を厳密に構成する。
from itertools import product

def cnfz_positive(a, b):
    return ((a >= 0 and b >= 0 and (a, b) != (0, 0))
        or (a > 0 and b < 0 and 2*b*b < a*a)
        or (a < 0 and b > 0 and a*a < 2*b*b))

def cnfz_rep(value, s):
    if value in QQ:
        result = (QQ(value), QQ.zero())
    else:
        minimal = value.minpoly()
        assert minimal.degree() == 2
        a = QQ(-minimal[1]/(2*minimal[2]))
        result = (a, QQ((value-QQbar(a))/s))
    assert value == QQbar(result[0])+QQbar(result[1])*s
    return result

cnfz_cases = []
cnfz_ring = PolynomialRing(ZZ, 'x')
cnfz_x = cnfz_ring.gen()
for L in (1, 2, 3):
    counts = [ZZ.zero()] * (2*L*L+1)
    polynomial = cnfz_ring.zero()
    for config in product((-1, 1), repeat=L*L):
        def spin(i, k):
            return config[(i % L)*L+(k % L)]
        broken = sum(spin(i,k) != spin(i+1,k) for i in range(L) for k in range(L))
        broken += sum(spin(i,k) != spin(i,k+1) for i in range(L) for k in range(L))
        counts[broken] += 1
        polynomial += cnfz_x**broken
    for s in (QQbar(2).sqrt(), -QQbar(2).sqrt()):
        xc = QQbar(QQ(-1))+s
        coeff_polynomial = sum(counts[m]*cnfz_x**m for m in range(len(counts)))
        explicit_sum = sum(QQbar(QQ(counts[m]))*xc**m for m in range(len(counts)))
        pair = cnfz_rep(explicit_sum, s)
        roots = polynomial.change_ring(QQbar).roots(multiplicities=False)
        cnfz_cases.append((L, s, xc, polynomial, coeff_polynomial, explicit_sum, pair, roots))
assert len(cnfz_cases) == 6
cnfz_zero = (QQ.zero(), QQ.zero())
_cnfz_ready = True
