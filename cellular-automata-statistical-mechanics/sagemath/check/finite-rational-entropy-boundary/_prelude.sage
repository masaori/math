from itertools import product


def canonical_vector(entries):
    return {
        ZZ(prime): QQ(coefficient)
        for prime, coefficient in entries.items()
        if coefficient != 0
    }


def positive_rational_valuation(value):
    value = QQ(value)
    assert value > 0
    entries = {}
    for prime, exponent in ZZ(value.numerator()).factor():
        entries[ZZ(prime)] = QQ(exponent)
    for prime, exponent in ZZ(value.denominator()).factor():
        entries[ZZ(prime)] = entries.get(ZZ(prime), QQ(0)) - QQ(exponent)
    return canonical_vector(entries)


def reconstruct(vector):
    numerator = prod(
        (prime ** ZZ(max(coefficient, 0)) for prime, coefficient in vector.items()),
        ZZ(1),
    )
    denominator = prod(
        (prime ** ZZ(max(-coefficient, 0)) for prime, coefficient in vector.items()),
        ZZ(1),
    )
    return QQ(numerator) / QQ(denominator)


def positive_support(weights):
    weights = tuple(QQ(weight) for weight in weights)
    assert weights
    assert all(QQ(0) <= weight <= QQ(1) for weight in weights)
    assert sum(weights) == QQ(1)
    return tuple(index for index, weight in enumerate(weights) if weight > 0)


def rational_entropy_vector(weights):
    weights = tuple(QQ(weight) for weight in weights)
    support = positive_support(weights)
    primes = set()
    valuations = {}
    for index in support:
        valuations[index] = positive_rational_valuation(weights[index])
        primes.update(valuations[index])
    return canonical_vector({
        prime: -sum(
            weights[index] * valuations[index].get(prime, QQ(0))
            for index in support
        )
        for prime in primes
    })


def sample_distributions():
    distributions = set()
    for length in range(1, 5):
        for denominator in range(1, 11):
            for numerators in product(range(denominator + 1), repeat=length):
                if sum(numerators) == denominator:
                    distributions.add(tuple(QQ(numerator) / denominator for numerator in numerators))
    return tuple(sorted(distributions))
