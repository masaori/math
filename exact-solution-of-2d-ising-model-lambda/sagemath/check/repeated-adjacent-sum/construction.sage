from itertools import product

def theta(u, v):
    return ZZ(u[1]) * ZZ(v[0]) - ZZ(u[0]) * ZZ(v[1])

def extend(u, j):
    return u[j] if j < len(u) else (ZZ(0), ZZ(0))

def internal(m, s):
    return sum((theta(s(j), s(j + 1)) for j in range(max(m - 1, 0))), ZZ(0))

def cyclic(m, s):
    return sum((theta(s(j), s((j + 1) % m)) for j in range(m)), ZZ(0))

def repeated_cases():
    alphabet = [(ZZ(1), ZZ(0)), (ZZ(0), ZZ(1)),
                (ZZ(-1), ZZ(-1)), (ZZ(0), ZZ(0))]
    words = [list(t) for n in range(1, 5) for t in product(alphabet, repeat=n)]
    words += [[(ZZ((seed + j * j) % 11 - 5), ZZ((2 * seed + 3 * j) % 13 - 6))
               for j in range(n)] for n in range(5, 13) for seed in range(8)]
    for u in words:
        for c in range(1, 7):
            yield u, c
