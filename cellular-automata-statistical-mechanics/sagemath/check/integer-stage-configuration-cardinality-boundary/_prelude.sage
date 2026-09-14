# 整数舞台上の有限台配位と全配位の濃度境界に共通する有限定義。
# 全て有限集合・ZZ・NNで閉じる。

import itertools


STATES = (ZZ(0), ZZ(1))


def integer_window(radius):
    return tuple(range(-radius, radius + 1))


def finite_window_configurations(radius):
    return tuple(itertools.product(STATES, repeat=2 * radius + 1))


def one_support(radius, values):
    return tuple(
        position
        for position, value in zip(integer_window(radius), values)
        if value == 1
    )


def diagonal_prefix(candidate_rows):
    return tuple(ZZ(1) - candidate_rows[index][index]
                 for index in range(len(candidate_rows)))
