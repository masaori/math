# 有限語個数の実数実現による規格化境界の有限検算で共有する定義。
# 有限台整数ベクトルは非零係数だけを辞書に持つ。
# 実数実現の有限例は QQ 値で計算し、標準単射 QQ -> RR の前で等号を厳密に判定する。


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


def natural_multiple(multiplier, vector):
    assert multiplier >= 0
    return canonical_vector(
        {prime: ZZ(multiplier) * coefficient for prime, coefficient in vector.items()}
    )


def prime_log_positive_integer(value):
    assert value > 0
    return canonical_vector({prime: exponent for prime, exponent in ZZ(value).factor()})


def rational_realization(vector, prime_weights):
    return sum(
        (
            QQ(coefficient) * QQ(prime_weights.get(prime, QQ(0)))
            for prime, coefficient in vector.items()
        ),
        QQ(0),
    )


def full_binary_word_count(length):
    assert length > 0
    return ZZ(2) ** ZZ(length)


def realized_density(length, prime_weights):
    assert length > 0
    count = full_binary_word_count(length)
    assert count > 0
    denominator = QQ(length)
    assert denominator != 0
    return rational_realization(prime_log_positive_integer(count), prime_weights) / denominator
