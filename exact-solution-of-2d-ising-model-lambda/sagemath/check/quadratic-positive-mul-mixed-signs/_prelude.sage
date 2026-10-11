# 対象ラベル: claim_quadratic_positive_mul_mixed_signs
# 恒等式は QQ 多項式、順序比較は入力の二つの混合符号条件だけで選ぶ。
from itertools import product

if 'qpm_polynomials' not in globals():
    qpm_polynomials = PolynomialRing(QQ, names=('a', 'u', 'cp', 'bp', 'p', 'q', 'r', 't'))

a, u, cp, bp, p, q, r, t = qpm_polynomials.gens()
b, ap = -u, -cp
A = a*ap + 2*(b*bp)
B = a*bp + b*ap
C = a*cp + 2*(u*bp)
D = a*a - 2*(u*u)


def rational_cases():
    positive = sorted(set(QQ(n)/QQ(d) for n in range(1, 7) for d in range(1, 7)))
    negative_second = [(a, u) for a in positive for u in positive if 2*(u*u) < a*a]
    negative_first = [(cp, bp) for cp in positive for bp in positive if cp*cp < 2*(bp*bp)]
    for (a, u), (cp, bp) in product(negative_second, negative_first):
        b, ap = -u, -cp
        A = a*ap + 2*(b*bp)
        B = a*bp + b*ap
        C = a*cp + 2*(u*bp)
        D = a*a - 2*(u*u)
        yield a, u, cp, bp, b, ap, A, B, C, D


if 'qpm_cases' not in globals():
    qpm_cases = tuple(rational_cases())
    assert len(qpm_cases) == 67308
    qpm_results = {}


def qpm_record(name, count, mode):
    assert count > 0, name
    qpm_results[name] = (int(count), mode)
    print('RESULT: PASS ' + name + ' (' + str(count) + '; ' + mode + ')')
