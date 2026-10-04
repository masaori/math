# 実際の辺番号・向きから回転表を読む。計算は整数だけを使う。
from itertools import product
D = ((0, 1), (1, 0), (0, -1), (-1, 0))
def add(p, u):
    return (p[0] + u[0], p[1] + u[1])
def project(L, p, u):
    side = 0 if u[0] == 0 else 1
    reverse = int(u[0] + u[1] < 0)
    base = add(p, u) if reverse else p
    return (side*L*L + L*(base[0] % L) + base[1] % L + 1, reverse)
def direction(L, e):
    return (0 if e[0] <= L*L else 1) + 2*e[1]
def endpoints(L, e):
    k = (e[0]-1) % (L*L)
    start = (k//L, k%L)
    step = (0, 1) if e[0] <= L*L else (1, 0)
    end = tuple(x % L for x in add(start, step))
    return (end, start) if e[1] else (start, end)
def tau(L, e, f):
    assert endpoints(L, e)[1] == endpoints(L, f)[0]
    assert f != (e[0], 1-e[1])
    return {0: 0, 1: 1, 3: -1}[(direction(L, f)-direction(L, e)) % 4]
def weight(u, v):
    return u[1]*v[0]-u[0]*v[1]
def local_rows():
    for L, base, u, v in product(range(1, 5), ((0, 0), (-3, 5)), D, D):
        if v == (-u[0], -u[1]):
            continue
        e, f = project(L, base, u), project(L, add(base, u), v)
        yield L, u, v, e, f

def closed_rows():
    for n in range(1, 7):
        for word in product(D, repeat=n):
            if any(word[(j+1)%n] == (-word[j][0], -word[j][1]) for j in range(n)):
                continue
            displacement = tuple(sum(u[k] for u in word) for k in range(2))
            for L in range(1, 5):
                if any(x % L for x in displacement):
                    continue
                for base in ((0, 0), (-3, 5)):
                    points = [base]
                    for u in word:
                        points.append(add(points[-1], u))
                    edges = [project(L, points[j], word[j]) for j in range(n)]
                    internal_tau = sum(tau(L, edges[j], edges[j+1]) for j in range(n-1))
                    close_tau = tau(L, edges[-1], edges[0])
                    internal_weight = sum(weight(word[j], word[j+1]) for j in range(n-1))
                    close_weight = weight(word[-1], word[0])
                    direct = sum(tau(L, edges[j], edges[(j+1)%n]) for j in range(n))
                    yield (word, edges, direct, internal_tau, close_tau, internal_weight, close_weight)
rows = list(closed_rows())
