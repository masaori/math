# 対象ラベル: def_even_orbit_minimum, def_even_orbit_coordinate, def_even_orbit_coloring, claim_even_orbit_minimum_color, claim_even_orbit_coloring
# 帰属: 有限番号集合、置換、自然数の反復回数と剰余だけを用いる。
from itertools import permutations


def iterate(sigma, exponent, point):
    for _ in range(exponent):
        point = sigma[point]
    return point


def orbit(sigma, point):
    seen = set()
    while point not in seen:
        seen.add(point)
        point = sigma[point]
    return frozenset(seen)


def period(sigma, point):
    exponent = ZZ(1)
    while iterate(sigma, exponent, point) != point:
        exponent += 1
    return exponent


def coordinate(sigma, point):
    start = min(orbit(sigma, point))
    exponents = [ZZ(k) for k in range(period(sigma, start))
                 if iterate(sigma, k, start) == point]
    assert len(exponents) == 1
    return exponents[0]


def all_cases():
    counts = {}
    for size in range(7):
        counts[size] = 0
        for sigma in permutations(range(size)):
            if any(len(orbit(sigma, i)) % 2 for i in range(size)):
                continue
            counts[size] += 1
            coloring = frozenset(i for i in range(size) if coordinate(sigma, i) % 2 == 0)
            yield sigma, coloring
    assert counts == {0: 1, 1: 0, 2: 1, 3: 0, 4: 9, 5: 0, 6: 225}, counts


CASES = list(all_cases())
ROWS = []
for sigma, coloring in CASES:
    for i in range(len(sigma)):
        m = min(orbit(sigma, i))
        p = period(sigma, m)
        r = coordinate(sigma, i)
        ROWS.append((sigma, coloring, i, m, p, r))
assert len(CASES) == 236
assert len(ROWS) == 1388
