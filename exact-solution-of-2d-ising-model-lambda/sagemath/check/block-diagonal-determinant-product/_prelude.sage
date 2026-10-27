from itertools import permutations, product

R = PolynomialRing(QQ, 'x')
x = R.gen()

def sign(indices, image):
    return (-1) ** sum(image[i] > image[j] for i in indices for j in indices if i < j)

def cases():
    for n in range(5):
        for blocks in product(range(3), repeat=n):
            fibers = [tuple(i for i in range(n) if blocks[i] == k) for k in range(3)]
            B = matrix(R, n, n, lambda i, j:
                R(i + j + 1) + R(i + 1) * R(j + 2) * x if blocks[i] == blocks[j] else R.zero())
            terms = []
            for family in product(*(permutations(fiber) for fiber in fibers)):
                image = list(range(n))
                for fiber, images in zip(fibers, family):
                    for i, j in zip(fiber, images):
                        image[i] = j
                whole = R(sign(range(n), image)) * prod((B[i, image[i]] for i in range(n)), R.one())
                parts = prod((R(sign(fiber, image)) * prod((B[i, image[i]] for i in fiber), R.one()) for fiber in fibers), R.one())
                terms.append((whole, parts))
            family_sum = sum((whole for whole, _ in terms), R.zero())
            factored_sum = sum((parts for _, parts in terms), R.zero())
            fiber_sums = []
            fiber_dets = []
            for fiber in fibers:
                fiber_sums.append(sum((R(sign(fiber, {i: j for i, j in zip(fiber, images)})) *
                    prod((B[i, j] for i, j in zip(fiber, images)), R.one())
                    for images in permutations(fiber)), R.zero()))
                fiber_dets.append(matrix(R, len(fiber), len(fiber),
                    lambda i, j: B[fiber[i], fiber[j]]).det())
            yield (B.det(), family_sum, factored_sum,
                prod(fiber_sums, R.one()), prod(fiber_dets, R.one()))
