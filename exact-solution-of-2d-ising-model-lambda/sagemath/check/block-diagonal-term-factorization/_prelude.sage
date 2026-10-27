from itertools import permutations, product

R = PolynomialRing(QQ, 'x')
x = R.gen()

def inversion_sign(indices, image):
    return (-1) ** sum(image[i] > image[j] for i in indices for j in indices if i < j)

def term_values():
    for n in range(5):
        for blocks in product(range(3), repeat=n):
            fibers = [tuple(i for i in range(n) if blocks[i] == k) for k in range(3)]
            B = matrix(R, n, n, lambda i, j: R(i + 1) + R(j + 2) * x)
            for family in product(*(permutations(fiber) for fiber in fibers)):
                image = list(range(n))
                for fiber, images in zip(fibers, family):
                    for i, j in zip(fiber, images):
                        image[i] = j
                full_product = prod((B[i, image[i]] for i in range(n)), R.one())
                signs = [inversion_sign(fiber, image) for fiber in fibers]
                sign_product = prod(signs, ZZ.one())
                fiber_products = [
                    prod((B[i, image[i]] for i in fiber), R.one())
                    for fiber in fibers
                ]
                yield (
                    inversion_sign(range(n), image) * full_product,
                    sign_product * full_product,
                    prod((R(s) for s in signs), R.one()) * full_product,
                    prod(fiber_products, R.one()) * prod((R(s) for s in signs), R.one()),
                    prod((R(s) * p for s, p in zip(signs, fiber_products)), R.one()),
                )
