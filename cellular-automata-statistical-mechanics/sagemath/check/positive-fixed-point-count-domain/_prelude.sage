# 有限全数データと直接反復。等式の判定は各 check_*.sage が行う。
import os
from itertools import product

load(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                  '..', 'minimal-preperiod-period', '_prelude.sage'))


def finite_maps():
    # X = {0,...,M-1}。M=0 の空写像も一度列挙する。
    for size in range(5):
        for mapping in product(range(size), repeat=size):
            yield ('finite-set', size, mapping), mapping


def binary_ca_maps():
    # 空舞台は一つの空配位・一つの大域写像を持つ。
    yield ('binary-ca', 0, None), (0,)
    for size in range(1, 4):
        configs = elementary_configurations(size)
        index = {config: position for position, config in enumerate(configs)}
        for rule in range(256):
            mapping = tuple(index[elementary_global_map(rule, x)] for x in configs)
            yield ('binary-ca', size, rule), mapping


def cases():
    yield from finite_maps()
    yield from binary_ca_maps()


def image_at(mapping, x, n):
    return iterate_map(mapping, x, n)[n]


def fixed_set(mapping, n):
    if n < 1:
        raise ValueError('positive exponent required')
    return {x for x in range(len(mapping)) if image_at(mapping, x, n) == x}


def count_fixed(mapping, n):
    return ZZ(sum(1 for x in range(len(mapping)) if image_at(mapping, x, n) == x))


def orbit_data(mapping):
    return tuple(direct_min_preperiod_period(iterate_map(mapping, x, len(mapping)))
                 for x in range(len(mapping)))


def periodic_set(mapping):
    # 正の戻り時間の有限走査。mu=0 という判定をここへ代入しない。
    return {x for x in range(len(mapping))
            if any(image_at(mapping, x, d) == x for d in range(1, len(mapping) + 1))}


def realized_lengths(mapping):
    data = orbit_data(mapping)
    return {data[x][1] for x in periodic_set(mapping)}


def rows():
    for name, mapping in cases():
        for n in range(1, max(1, 2 * len(mapping)) + 1):
            yield name, mapping, n


def collisions():
    for name, mapping in cases():
        for x in range(len(mapping)):
            prefix = iterate_map(mapping, x, len(mapping))
            for i in range(len(mapping) + 1):
                for j in range(i + 1, len(mapping) + 1):
                    if prefix[i] == prefix[j]:
                        yield name, mapping, x, i, j, j - i, prefix[i]


def positive_rational_input(mapping, n):
    if n < 1:
        raise ValueError('positive exponent required')
    count = count_fixed(mapping, n)
    if count == 0:
        raise ValueError('exponent outside the positive-count domain')
    return QQ(count) / QQ(1)


CELL = 'v'
STATES = (0, 1)
NEGATION = {0: 1, 1: 0}


def configuration(a):
    return {CELL: a}


def restriction(x):
    return {CELL: x[CELL]}


def local_flip(z):
    return NEGATION[z[CELL]]


def global_flip(x):
    return {CELL: local_flip(restriction(x))}


def flip_iterate(x, n):
    value = x
    for _ in range(n):
        value = global_flip(value)
    return value
