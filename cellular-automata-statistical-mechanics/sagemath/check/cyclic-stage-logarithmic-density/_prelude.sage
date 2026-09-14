# 有限巡回舞台の一方向シフトと対数順序群内の規格化に共通する有限定義。
# 全て有限集合・ZZ・NN・有限台整数ベクトルで閉じる。

import itertools


STATES = (0, 1)


def configurations(length):
    return tuple(itertools.product(STATES, repeat=length))


def shift_image(configuration):
    length = len(configuration)
    return tuple(configuration[(vertex + 1) % length] for vertex in range(length))


def prime_vector(positive_integer):
    assert positive_integer > 0
    return tuple((ZZ(prime), ZZ(exponent)) for prime, exponent in factor(ZZ(positive_integer)))


def reconstruct_prime_vector(vector):
    value = ZZ(1)
    for prime, exponent in vector:
        value *= prime ** exponent
    return value


def is_divisible_vector(vector, divisor):
    assert divisor != 0
    return all(ZZ(coefficient) % ZZ(divisor) == 0 for _, coefficient in vector)

