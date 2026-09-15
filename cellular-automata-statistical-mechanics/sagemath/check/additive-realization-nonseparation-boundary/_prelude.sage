# 加法的実数実現の識別力境界の有限反例で共有する定義。
# 有限台整数ベクトルは非零係数だけを辞書に持つ。
# 零実数実現の値は、標準単射 QQ -> RR で実数の零になる QQ(0) として厳密に計算する。


def canonical_vector(entries):
    return {
        ZZ(prime): ZZ(coefficient)
        for prime, coefficient in entries.items()
        if coefficient != 0
    }


def vector_add(left, right):
    primes = set(left).union(right)
    return canonical_vector(
        {prime: left.get(prime, ZZ(0)) + right.get(prime, ZZ(0)) for prime in primes}
    )


def prime_log_positive_integer(value):
    assert value > 0
    return canonical_vector({prime: exponent for prime, exponent in ZZ(value).factor()})


def reconstruct(vector):
    numerator = prod(
        (ZZ(prime) ** max(ZZ(coefficient), ZZ(0)) for prime, coefficient in vector.items()),
        ZZ(1),
    )
    denominator = prod(
        (ZZ(prime) ** max(-ZZ(coefficient), ZZ(0)) for prime, coefficient in vector.items()),
        ZZ(1),
    )
    return QQ(numerator) / QQ(denominator)


def zero_realization(vector):
    canonical_vector(vector)
    return QQ(0)
