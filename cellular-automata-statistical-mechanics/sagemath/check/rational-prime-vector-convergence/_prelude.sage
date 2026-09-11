# 有限台有理素数ベクトルの有限和差量に共通する定義。
# 有限集合・ZZ・QQ と有限台辞書だけを使う。

import itertools


PRIMES = (ZZ(2), ZZ(3), ZZ(5))


def coefficient(vector, prime):
    return vector.get(ZZ(prime), QQ(0))


def support(vector):
    return {ZZ(prime) for prime, value in vector.items() if QQ(value) != 0}


def zero_vector():
    return {}


def finite_sum_distance(left, right):
    union_support = support(left).union(support(right))
    return sum((abs(coefficient(left, prime) - coefficient(right, prime))
                for prime in union_support), QQ(0))


def shift_normalized_vector(length):
    assert length > 0
    return {ZZ(2): QQ(1) / QQ(length)}
