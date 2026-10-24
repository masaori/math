# 帰属: 有限番号集合と自然数。浮動小数点を用いない。
from itertools import permutations


def compose(f, g):
    return tuple(f[g[i]] for i in range(len(g)))


def iterate(f, exponent, point):
    for _ in range(exponent):
        point = f[point]
    return point


def orbit(f, point):
    seen = set()
    while point not in seen:
        seen.add(point)
        point = f[point]
    return frozenset(seen)


def cases():
    counts = {}
    for size in (0, 2, 4, 6):
        involutions = [f for f in permutations(range(size))
                       if all(f[i] != i and f[f[i]] == i for i in range(size))]
        counts[size] = 0
        for tau in involutions:
            for upsilon in involutions:
                counts[size] += 1
                yield tau, upsilon, compose(upsilon, tau), compose(tau, upsilon)
    assert counts == {0: 1, 2: 1, 4: 9, 6: 225}, counts


CASES = list(cases())
ROWS = [(tau, upsilon, p, q, i) for tau, upsilon, p, q in CASES
        for i in range(len(tau))]
assert len(CASES) == 236
assert len(ROWS) == 1388
MAX_EXPONENT = 12
