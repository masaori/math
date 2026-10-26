from itertools import permutations, product

R = PolynomialRing(QQ, 'x')
x = R.gen()
cases = 0
for n in range(5):
    for blocks in product(range(2), repeat=n):
        B = matrix(R, n, n, lambda i, j:
                   (i + 1) + (j + 1) * x if blocks[i] == blocks[j] else R.zero())
        full = R.zero()
        preserving = R.zero()
        for sigma in permutations(range(n)):
            inversions = sum(sigma[i] > sigma[j] for i in range(n) for j in range(i + 1, n))
            sign = (-1) ** inversions
            factors = [B[i, sigma[i]] for i in range(n)]
            term = sign * prod(factors, R.one())
            full += term
            if all(blocks[sigma[i]] == blocks[i] for i in range(n)):
                preserving += term
            else:
                j = next(i for i in range(n) if blocks[sigma[i]] != blocks[i])
                remainder = prod((factors[i] for i in range(n) if i != j), R.one())
                assert prod(factors, R.one()) == factors[j] * remainder
                assert factors[j] == R.zero()
                assert factors[j] * remainder == R.zero()
                assert term == R.zero()
            cases += 1
        assert B.det() == full
        assert full == preserving

print(f"PASS: {cases} permutation terms")
