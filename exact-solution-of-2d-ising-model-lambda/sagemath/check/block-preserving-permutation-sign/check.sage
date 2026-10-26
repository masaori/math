from itertools import permutations, product
from math import prod

cases = 0
for n in range(6):
    indices = tuple(range(n))
    for blocks in product(range(3), repeat=n):
        fibers = tuple(tuple(j for j in indices if blocks[j] == k) for k in range(3))
        for sigma in permutations(indices):
            if any(blocks[sigma[j]] != blocks[j] for j in indices):
                continue
            same = sum(sigma[i] > sigma[j]
                       for fiber in fibers for i in fiber for j in fiber if i < j)
            cross = 0
            for k in range(3):
                for l in range(k + 1, 3):
                    fiber_pairs = tuple(product(fibers[k], fibers[l]))
                    original_order = sum(i < j for i, j in fiber_pairs)
                    image_order = sum(sigma[i] < sigma[j] for i, j in fiber_pairs)
                    assert original_order == image_order
                    flipped = sum((i < j) != (sigma[i] < sigma[j])
                                  for i, j in fiber_pairs)
                    assert flipped % 2 == 0
                    cross += flipped
            inversions = sum(sigma[i] > sigma[j]
                             for i in indices for j in indices if i < j)
            assert inversions == same + cross
            assert (-1) ** inversions == prod((-1) ** sum(
                sigma[i] > sigma[j] for i in fiber for j in fiber if i < j)
                for fiber in fibers)
            cases += 1

print(f"PASS: {cases} block-preserving permutations")
