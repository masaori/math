# 整数除法による定義と、単位歩を順に足した列を別々に作る。
from itertools import product

transverse_geometries = []
for wh, wv in product(range(-3, 4), repeat=2):
    if wh == 0 and wv == 0:
        continue
    d = vector(ZZ, (wh, -wv))
    steps = ([vector(ZZ, (sign(wh), 0)) for _ in range(abs(wh))]
             + [vector(ZZ, (0, -sign(wv))) for _ in range(abs(wv))])
    n = len(steps)
    C = [vector(ZZ, (0, 0))]
    for step in steps:
        C.append(C[-1] + step)
    assert C[-1] == d
    for t in range(1, 5):
        origin = [vector(ZZ, (0, 0))]
        for step in steps * t:
            origin.append(origin[-1] + step)
        for base in ((0, 0), (-5, 2), (3, -4)):
            Q = vector(ZZ, base)
            transverse_geometries.append((wh, wv, n, t, Q, d, C, origin))


def staircase(g, Q, s):
    wh, wv, n, t, base, d, C, origin = g
    return Q + (s // n) * d + C[s % n]


def point_rows():
    for g in transverse_geometries:
        wh, wv, n, t, Q, d, C, origin = g
        for s in range(t*n + 1):
            yield g, Q, d, C, s, s // n, s % n


def step_rows():
    for g in transverse_geometries:
        wh, wv, n, t, Q, d, C, origin = g
        b = t*n
        for reverse in (False, True):
            for i in range(b):
                first = b-i if reverse else i
                last = b-(i+1) if reverse else i+1
                assert 0 <= first <= b and 0 <= last <= b
                yield g, Q, first, last


def closure_rows():
    for g in transverse_geometries:
        wh, wv, n, t, S, d, C, origin = g
        b = t*n
        for L in range(1, 4):
            B = vector(ZZ, (L*wv, L*wh))
            for c in range(1, 4):
                upper = [staircase(g, S+c*B, s) for s in range(b+1)]
                lower = [staircase(g, S, b-s) for s in range(b+1)]
                for i in range(b):
                    yield g, S, B, c, b, i, upper, lower
