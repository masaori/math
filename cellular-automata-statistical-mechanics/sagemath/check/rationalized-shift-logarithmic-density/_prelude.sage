# 一方向シフトの有理係数正規化列に共通する可算側の定義。
# 全て有限集合・ZZ・QQ・有限台ベクトルで閉じる。

import itertools


STATES = (0, 1)
PRIMES = (ZZ(2), ZZ(3), ZZ(5))


def configurations(length):
    return tuple(itertools.product(STATES, repeat=length))


def shift_image(configuration):
    length = len(configuration)
    return tuple(configuration[(vertex + 1) % length] for vertex in range(length))


def integer_prime_vector(positive_integer):
    assert positive_integer > 0
    return {ZZ(prime): ZZ(exponent)
            for prime, exponent in factor(ZZ(positive_integer))}


def rational_embedding(vector):
    return {ZZ(prime): QQ(coefficient)
            for prime, coefficient in vector.items()
            if coefficient != 0}


def divide_rational_vector(vector, positive_integer):
    assert positive_integer > 0
    divisor = QQ(positive_integer)
    return {ZZ(prime): QQ(coefficient) / divisor
            for prime, coefficient in vector.items()
            if coefficient != 0}


def coefficient(vector, prime):
    return vector.get(ZZ(prime), QQ(0))
