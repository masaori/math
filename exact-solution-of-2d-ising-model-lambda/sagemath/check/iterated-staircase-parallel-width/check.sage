"""反復横断階段の平行座標が基点から幅以内に収まることを ZZ 上で検査する。

対象:
- claim_iterated_staircase_parallel_width_bound
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
offset_total = 0
for L in range(1, 6):
    for w_h in range(-L, L + 1):
        for w_v in range(-L, L + 1):
            w_h = ZZ(w_h)
            w_v = ZZ(w_v)
            if (w_h, w_v) == (ZZ(0), ZZ(0)):
                continue
            stair = staircase(w_h, w_v)
            product = w_h * w_v
            for base in ((ZZ(0), ZZ(0)), (ZZ(2), ZZ(-3))):
                for repetition in (1, 2, 3):
                    points = iterated_staircase(base, repetition, w_h, w_v, stair)
                    base_parallel = parallel(base, w_h, w_v)
                    for point in points:
                        offset = parallel(point, w_h, w_v) - base_parallel
                        assert min(ZZ(0), product) <= offset
                        assert offset <= max(ZZ(0), product)
                        offset_total += 1
            winding_pair_total += 1

print(f"PASS: {winding_pair_total} nonzero winding pairs "
      f"({offset_total} parallel-coordinate offsets within the width bound "
      f"over L=1,...,5)")
