# 有限台有理素数ベクトルの完備性境界に共通する定義。
# 有限集合・ZZ・QQ と有限台辞書だけを使う。


def coefficient(vector, prime):
    return QQ(vector.get(ZZ(prime), QQ(0)))


def support(vector):
    return {ZZ(prime) for prime, value in vector.items() if QQ(value) != 0}


def finite_sum_distance(left, right):
    union_support = support(left).union(support(right))
    return sum((abs(coefficient(left, prime) - coefficient(right, prime))
                for prime in union_support), QQ(0))


_prime_cache = {}


def increasing_prime(index):
    assert index > 0
    index = ZZ(index)
    if index not in _prime_cache:
        _prime_cache[index] = ZZ(nth_prime(index))
    return _prime_cache[index]


_geometric_truncation_cache = {}


def geometric_truncation(length):
    assert length > 0
    length = ZZ(length)
    if length not in _geometric_truncation_cache:
        _geometric_truncation_cache[length] = {
            increasing_prime(index): QQ(1) / QQ(2 ** index)
            for index in range(1, length + 1)
        }
    return _geometric_truncation_cache[length]
