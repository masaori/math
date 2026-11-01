"""反復横断階段が非零の周期並進と交わらないことを ZZ 上で検査する。

対象:
- claim_period_translates_of_iterated_staircase_disjoint
"""


def integer_sign(value):
    if value < 0:
        return ZZ(-1)
    if value > 0:
        return ZZ(1)
    return ZZ(0)


def parallel(point, w_h, w_v):
    row, col = point
    return w_v * row + w_h * col


def staircase(w_h, w_v):
    height = abs(w_h)
    width = abs(w_v)
    points = [(integer_sign(w_h) * s, ZZ(0)) for s in range(height + 1)]
    points += [(w_h, -integer_sign(w_v) * t) for t in range(1, width + 1)]
    return points


def iterated_staircase(base, repetition, w_h, w_v, stair):
    n_perp = len(stair) - 1
    points = []
    for s in range(repetition * n_perp + 1):
        q, r = divmod(s, n_perp)
        points.append((base[0] + ZZ(q) * w_h + stair[r][0],
                       base[1] - ZZ(q) * w_v + stair[r][1]))
    return points


winding_pair_total = 0
staircase_vertex_total = 0
translated_comparison_total = 0
for L in range(1, 6):
    for w_h in range(-L, L + 1):
        for w_v in range(-L, L + 1):
            w_h = ZZ(w_h)
            w_v = ZZ(w_v)
            if (w_h, w_v) == (ZZ(0), ZZ(0)):
                continue
            stair = staircase(w_h, w_v)
            product = w_h * w_v
            period = (ZZ(L) * w_v, ZZ(L) * w_h)
            period_parallel = ZZ(L) * (w_h**2 + w_v**2)
            assert period_parallel > abs(product)
            for base in ((ZZ(0), ZZ(0)), (ZZ(2), ZZ(-3))):
                for repetition in (1, 2, 3):
                    points = iterated_staircase(base, repetition, w_h, w_v, stair)
                    offsets = [parallel(point, w_h, w_v) - parallel(base, w_h, w_v)
                               for point in points]
                    assert min(ZZ(0), product) <= min(offsets)
                    assert max(offsets) <= max(ZZ(0), product)
                    staircase_vertex_total += len(points)
                    for z in (-2, -1, 1, 2):
                        translated = {(point[0] + ZZ(z) * period[0],
                                       point[1] + ZZ(z) * period[1])
                                      for point in points}
                        for point in points:
                            for translated_point in translated:
                                assert point != translated_point
                                translated_comparison_total += 1
            winding_pair_total += 1

print(f"PASS: {winding_pair_total} nonzero winding pairs "
      f"({staircase_vertex_total} staircase vertices and "
      f"{translated_comparison_total} comparisons with nonzero period translates "
      f"over L=1,...,5)")
