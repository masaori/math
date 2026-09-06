# 有限巡回群の族・有限窓上一致・有限段階の量の列に共通する有限定義。
# 全て有限集合・ZZ・NN・有限台整数ベクトルで閉じる。

import itertools


STATES = (0, 1)


def cells(length):
    return tuple(range(length))


def offsets(radius):
    return tuple(range(-radius, radius + 1))


def configurations(length):
    return tuple(itertools.product(STATES, repeat=length))


def truth_tables(radius):
    argument_count = ZZ(2) ** ZZ(2 * radius + 1)
    return tuple(itertools.product(STATES, repeat=argument_count))


def argument_index(values):
    index = ZZ(0)
    for value in values:
        index = 2 * index + value
    return index


def global_image(configuration, length, radius, table):
    return tuple(
        table[argument_index(tuple(configuration[(vertex + offset) % length]
                                   for offset in offsets(radius)))]
        for vertex in cells(length)
    )


def iterate_global(configuration, length, radius, table, exponent):
    value = configuration
    for _ in range(exponent):
        value = global_image(value, length, radius, table)
    return value


def fixed_points(length, radius, table, exponent):
    return tuple(
        configuration
        for configuration in configurations(length)
        if iterate_global(configuration, length, radius, table, exponent) == configuration
    )


def prime_vector(positive_integer):
    assert positive_integer > 0
    return tuple((ZZ(prime), ZZ(exponent)) for prime, exponent in factor(ZZ(positive_integer)))


def reconstruct_prime_vector(vector):
    value = ZZ(1)
    for prime, exponent in vector:
        value *= prime ** exponent
    return value
