# 共通の対数演算は既存本文の実装を使う。有限校正の入力だけをここで作る。
import os
from collections import Counter
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '../logarithmic-counts/_prelude.sage'))

SIZES = (3, 4, 5, 6)
SLOPES = (-2, -1, 0, 1, 2)

def elementary_maps():
    for size in SIZES:
        configs = tuple(product((0, 1), repeat=size))
        index = {x: i for i, x in enumerate(configs)}
        for rule in range(256):
            table = tuple((rule >> k) & 1 for k in range(8))
            mapping = tuple(index[tuple(table[4*x[(v-1)%size] + 2*x[v] + x[(v+1)%size]]
                for v in range(size))] for x in configs)
            yield size, rule, configs, mapping

def time_rows():
    for size, rule, configs, mapping in elementary_maps():
        current = tuple(range(len(configs)))
        for n in range(1, 2*len(configs)+1):
            current = tuple(mapping[y] for y in current)
            fixed = frozenset(x for x, y in enumerate(current) if x == y)
            yield size, rule, configs, mapping, n, fixed

def observable(configs, slope):
    # A は二元集合のまま。指示関数 [x(v)=1] の自然数和を明示して整数へ送る。
    return tuple(ZZ(slope)*ZZ(sum(1 for z in x if z == 1)) for x in configs)

def observable_rows():
    for size, rule, configs, mapping in elementary_maps():
        for slope in SLOPES:
            H = observable(configs, slope)
            yield size, rule, configs, mapping, slope, H

def calibration_rows():
    for size, rule, configs, mapping in elementary_maps():
        accepted = [(slope, observable(configs, slope)) for slope in SLOPES
                    if conserved(mapping, observable(configs, slope))]
        current = tuple(range(len(configs)))
        for n in range(1, 2*len(configs)+1):
            current = tuple(mapping[y] for y in current)
            fixed = frozenset(x for x, y in enumerate(current) if x == y)
            for slope, H in accepted:
                fibers = {u: frozenset(x for x in fixed if H[x] == u) for u in set(H)}
                counts = {u: ZZ(len(E)) for u, E in fibers.items()}
                D = frozenset(u for u, count in counts.items() if count > 0)
                yield size, rule, mapping, slope, H, n, fixed, fibers, counts, D

def row_entropy(counts, u):
    return logarithm(QQ(counts.get(u, ZZ(0)))/QQ(1))

def row_beta(counts, u):
    return sub(row_entropy(counts, u+1), row_entropy(counts, u))

def row_rational_count(fixed):
    if not fixed:
        raise ValueError("positive rational required")
    return QQ(len(fixed))/QQ(1)

def row_free(fixed):
    return logarithm(row_rational_count(fixed))

def adjacent_calibration_rows():
    for size, rule, mapping, slope, H, n, fixed, fibers, counts, D in calibration_rows():
        for u in sorted(D):
            if u+1 in D:
                yield counts, u, counts[u], counts[u+1]
