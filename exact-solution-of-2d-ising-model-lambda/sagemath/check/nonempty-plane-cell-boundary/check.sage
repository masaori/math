from itertools import combinations

coords = [(ZZ(r), ZZ(c)) for r in range(-1, 2) for c in range(-1, 2)]
checked = 0

for size in range(1, len(coords) + 1):
    for chosen in combinations(coords, size):
        cells = set(chosen)
        r = max(p[0] for p in cells)
        c = next(p[1] for p in cells if p[0] == r)
        upper_edge = (False, (r + 1, c))
        assert (r, c) in cells
        assert (r + 1, c) not in cells
        horizontal_boundary = {
            (False, (a, b))
            for s, d in cells
            for a, b in ((s, d), (s + 1, d))
            if ((a, b) in cells) != ((a - 1, b) in cells)
        }
        vertical_boundary = {
            (True, (a, b))
            for s, d in cells
            for a, b in ((s, d), (s, d + 1))
            if ((a, b) in cells) != ((a, b - 1) in cells)
        }
        boundary = horizontal_boundary | vertical_boundary
        assert upper_edge in horizontal_boundary
        assert boundary
        checked += 1

print(f"PASS: nonempty cell sets={checked}, exposed upper edge in boundary")
