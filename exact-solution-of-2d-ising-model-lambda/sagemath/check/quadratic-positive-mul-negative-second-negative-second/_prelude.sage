# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 帰属: QQ。恒等式は QQ 上の多項式環、順序比較は QQ で確かめる。
from itertools import product
R = PolynomialRing(QQ, names=('a','u','ap','up','p','q','r','t'))
a,u,ap,up,p,q,r,t = R.gens()
b,bp = -u,-up
A = a*ap+2*(b*bp)
B = a*bp+b*ap
V = a*up+u*ap
D = a*a-2*(u*u)

def rational_cases():
    positive = sorted(set(QQ(n)/QQ(d) for n in range(1,7) for d in range(1,7)))
    pairs = [(v,w) for v in positive for w in positive if 2*w*w < v*v]
    for (a,u),(ap,up) in product(pairs, repeat=2):
        b,bp = -u,-up
        A = a*ap+2*(b*bp)
        B = a*bp+b*ap
        V = a*up+u*ap
        D = a*a-2*(u*u)
        yield a,u,ap,up,b,bp,A,B,V,D
