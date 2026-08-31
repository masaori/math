"""基点の平行座標が幅を超えて離れた二つの反復横断階段が交わらないことを ZZ 上で検査する。

対象:
- claim_parallel_separated_staircases_disjoint
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
base_pair_total = 0
comparison_total = 0
for L in range(1, 6):
    for w_h in range(-L, L + 1):
        for w_v in range(-L, L + 1):
            w_h = ZZ(w_h)
            w_v = ZZ(w_v)
            if (w_h, w_v) == (ZZ(0), ZZ(0)):
                continue
            stair = staircase(w_h, w_v)
            product = w_h * w_v
            base = (ZZ(0), ZZ(0))
            # 平行座標の差が w_h^2 + w_v^2 (> |w_h w_v|) になる基点と、
            # それへ横断移動ベクトル (w_h, -w_v)（平行座標 0）を足した基点。
            separated_bases = [
                (ZZ(c) * w_v, ZZ(c) * w_h) for c in (1, -1)
            ] + [
                (ZZ(c) * w_v + w_h, ZZ(c) * w_h - w_v) for c in (1, -1)
            ]
            for other in separated_bases:
                gap = parallel(base, w_h, w_v) - parallel(other, w_h, w_v)
                assert abs(gap) > abs(product)
                for rep_a in (1, 2):
                    for rep_b in (1, 2):
                        points_a = iterated_staircase(base, rep_a, w_h, w_v, stair)
                        points_b = iterated_staircase(other, rep_b, w_h, w_v, stair)
                        for point_a in points_a:
                            for point_b in points_b:
                                assert point_a != point_b
                                comparison_total += 1
                base_pair_total += 1
            winding_pair_total += 1

print(f"PASS: {winding_pair_total} nonzero winding pairs "
      f"({base_pair_total} separated base pairs and "
      f"{comparison_total} vertex comparisons between two staircases "
      f"over L=1,...,5)")
