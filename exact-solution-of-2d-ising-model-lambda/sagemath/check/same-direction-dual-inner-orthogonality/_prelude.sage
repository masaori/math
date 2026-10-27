from itertools import product

def cases():
    for L in range(1, 5):
        root = QQbar.zeta(2 * L)
        for a, b, delta in product(range(2), range(2), range(4)):
            horizontal = [root ** (a + 2 * k) for k in range(L)]
            vertical = [root ** (b + 2 * k) for k in range(L)]
            for varpi, varsigma, varpi_prime, varsigma_prime in product(
                    horizontal, vertical, horizontal, vertical):
                yield L, delta, varpi, varsigma, varpi_prime, varsigma_prime
