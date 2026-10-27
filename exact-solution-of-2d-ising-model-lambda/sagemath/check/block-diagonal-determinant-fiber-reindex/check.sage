from itertools import permutations, product

R = PolynomialRing(QQ, 'x')
x = R.gen()
cases = 0
for n in range(5):
    for blocks in product(range(3), repeat=n):
        B = matrix(R, n, n, lambda i, j:
                   R(i + 1) + R(j + 2) * x if blocks[i] == blocks[j] else R.zero())
        fibers = [tuple(i for i in range(n) if blocks[i] == k) for k in range(3)]
        preserving = R.zero()
        for sigma in permutations(range(n)):
            if all(blocks[sigma[i]] == blocks[i] for i in range(n)):
                inv = sum(sigma[i] > sigma[j] for i in range(n) for j in range(i + 1, n))
                preserving += (-1)**inv * prod((B[i, sigma[i]] for i in range(n)), R.one())
        glued_sum = R.zero()
        for family in product(*(permutations(fiber) for fiber in fibers)):
            sigma = list(range(n))
            for fiber, images in zip(fibers, family):
                for i, j in zip(fiber, images):
                    sigma[i] = j
            inv = sum(sigma[i] > sigma[j] for i in range(n) for j in range(i + 1, n))
            glued_sum += (-1)**inv * prod((B[i, sigma[i]] for i in range(n)), R.one())
            cases += 1
        assert B.det() == preserving
        assert preserving == glued_sum

print(f"PASS: {cases} permutation families")
