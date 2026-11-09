from itertools import combinations

cells = [(ZZ(r), ZZ(c)) for r in range(-1, 2) for c in range(-1, 2)]

def boundary(subset):
    edges = set()
    for r, c in subset:
        edges.update({(False, (r, c)), (False, (r + 1, c)),
                      (True, (r, c)), (True, (r, c + 1))})
    result = set()
    for vertical, (r, c) in edges:
        adjacent = (r, c - 1) if vertical else (r - 1, c)
        if ((r, c) in subset) != (adjacent in subset):
            result.add((vertical, (r, c)))
    return frozenset(result)

images = {}
image_of = {}
for size in range(len(cells) + 1):
    for chosen in combinations(cells, size):
        subset = frozenset(chosen)
        image = boundary(subset)
        image_of[subset] = image
        assert image not in images or images[image] == subset
        images[image] = subset

assert len(images) == 2 ** len(cells)
for first, first_boundary in image_of.items():
    for second, second_boundary in image_of.items():
        assert image_of[first.symmetric_difference(second)] == first_boundary.symmetric_difference(second_boundary)
        if first_boundary == second_boundary:
            assert first == second

print(f"PASS: {len(images)} cell sets and {len(images) ** 2} pairs")
