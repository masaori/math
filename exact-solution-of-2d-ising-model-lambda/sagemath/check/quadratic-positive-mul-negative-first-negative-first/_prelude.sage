# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 恒等式は QQ 多項式、順序比較は負の第一係数条件を満たす QQ の標本で確かめる。
from itertools import product
R = PolynomialRing(QQ, names=('c', 'b', 'cp', 'bp', 'p', 'q', 'r', 't'))
c, b, cp, bp, p, q, r, t = R.gens()
a, ap = -c, -cp
A = a*ap + 2*(b*bp)
B = a*bp + b*ap
V = c*bp + b*cp
D = 2*(b*b) - c*c


def rational_cases():
    positive = sorted(set(QQ(n)/QQ(d) for n in range(1, 7) for d in range(1, 7)))
    pairs = [(v, w) for v in positive for w in positive if v*v < 2*w*w]
    for (c, b), (cp, bp) in product(pairs, repeat=2):
        a, ap = -c, -cp
        A = a*ap + 2*(b*bp)
        B = a*bp + b*ap
        V = c*bp + b*cp
        D = 2*(b*b) - c*c
        yield c, b, cp, bp, a, ap, A, B, V, D
