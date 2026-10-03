from itertools import product

def theta(u, v):
    return ZZ(u[1]) * ZZ(v[0]) - ZZ(u[0]) * ZZ(v[1])

def internal(u):
    return sum((theta(u[j], u[j + 1]) for j in range(len(u) - 1)), ZZ(0))

def cyclic(u):
    return sum((theta(u[j], u[(j + 1) % len(u)]) for j in range(len(u))), ZZ(0))

def binary_cases():
    alphabet = [(ZZ(1), ZZ(0)), (ZZ(0), ZZ(1)), (ZZ(-1), ZZ(-1))]
    words = [list(t) for n in range(1, 5) for t in product(alphabet, repeat=n)]
    for u, v in product(words, repeat=2):
        yield u, v

def four_cases():
    alphabet = [(ZZ(1), ZZ(0)), (ZZ(0), ZZ(1)), (ZZ(-1), ZZ(-1))]
    for values in product(alphabet, repeat=4):
        yield tuple([value] for value in values)
    for lengths in product(range(1, 5), repeat=4):
        for seed in range(8):
            yield tuple([(ZZ((seed + 3 * k + j * j) % 11 - 5),
                          ZZ((2 * seed - k * k + 3 * j) % 13 - 6))
                         for j in range(n)] for k, n in enumerate(lengths))
