def canonical_vector(entries):
    return {
        ZZ(prime): ZZ(coefficient)
        for prime, coefficient in entries.items()
        if coefficient != 0
    }


def positive_rational_valuation(value):
    value = QQ(value)
    assert value > 0
    entries = {}
    for prime, exponent in ZZ(value.numerator()).factor():
        entries[ZZ(prime)] = ZZ(exponent)
    for prime, exponent in ZZ(value.denominator()).factor():
        entries[ZZ(prime)] = entries.get(ZZ(prime), ZZ(0)) - ZZ(exponent)
    return canonical_vector(entries)


def vector_subtract(left, right):
    primes = set(left).union(right)
    return canonical_vector({
        prime: left.get(prime, ZZ(0)) - right.get(prime, ZZ(0))
        for prime in primes
    })


def formal_logarithmic_realization(vector, logarithms):
    return sum(
        coefficient * logarithms[prime]
        for prime, coefficient in vector.items()
    )


def positive_rational_samples():
    return tuple(sorted({
        QQ(numerator) / denominator
        for numerator in range(1, 33)
        for denominator in range(1, 33)
    }))
