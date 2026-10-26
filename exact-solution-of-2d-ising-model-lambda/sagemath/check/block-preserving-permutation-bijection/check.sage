from itertools import permutations, product

cases = 0
for n in range(6):
    indices = tuple(range(n))
    for blocks in product(range(3), repeat=n):
        fibers = tuple(tuple(j for j in indices if blocks[j] == k) for k in range(3))
        preserving = tuple(sigma for sigma in permutations(indices)
                           if all(blocks[sigma[j]] == blocks[j] for j in indices))
        restrictions = set()
        for sigma in preserving:
            parts = tuple(tuple(sigma[j] for j in fiber) for fiber in fibers)
            restrictions.add(parts)
            glued = tuple(next(parts[k][fiber.index(j)]
                               for k, fiber in enumerate(fibers) if j in fiber)
                           for j in indices)
            assert glued == sigma
        all_parts = product(*(permutations(fiber) for fiber in fibers))
        for parts in all_parts:
            glued = tuple(next(parts[k][fiber.index(j)]
                               for k, fiber in enumerate(fibers) if j in fiber)
                           for j in indices)
            assert glued in preserving
            assert tuple(tuple(glued[j] for j in fiber) for fiber in fibers) == parts
            assert parts in restrictions
            cases += 1
        assert len(restrictions) == len(preserving)

print(f"PASS: {cases} block-preserving permutations")
