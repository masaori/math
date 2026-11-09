from itertools import combinations


def edges_of_cell(p):
    r, c = p
    return {(False, r, c), (False, r + 1, c),
            (True, r, c), (True, r, c + 1)}


def boundary(selected):
    edges = set().union(*(edges_of_cell(p) for p in selected)) if selected else set()
    return {e for e in edges
            if ((e[1], e[2]) in selected) !=
               (((e[1], e[2] - 1) if e[0] else (e[1] - 1, e[2])) in selected)}


def even(edges):
    vertices = {(r, c) for r in range(-1, 4) for c in range(-1, 4)}
    return all((sum((False, r, d) in edges for d in (c, c - 1)) +
                sum((True, d, c) in edges for d in (r, r - 1))) % 2 == 0
               for r, c in vertices)


def exterior_connected(cells):
    outer = {(r, c) for r in range(-2, 4) for c in range(-2, 4)} - cells
    seen = {(-2, -2)}
    stack = [(-2, -2)]
    while stack:
        r, c = stack.pop()
        for q in ((r + 1, c), (r - 1, c), (r, c + 1), (r, c - 1)):
            if q in outer - seen:
                seen.add(q)
                stack.append(q)
    return seen == outer


base = {(r, c) for r in range(2) for c in range(2)}
checked = 0
for size in range(5):
    for choice in combinations(sorted(base), size):
        cells = set(choice)
        if not exterior_connected(cells):
            continue
        support = sorted(set().union(*(edges_of_cell(p) for p in cells))) if cells else []
        images = []
        for selected_size in range(size + 1):
            for selected_choice in combinations(choice, selected_size):
                selected = set(selected_choice)
                image = boundary(selected)
                assert image <= set(support)
                assert even(image)
                images.append(frozenset(image))
        assert len(images) == len(set(images))
        targets = {frozenset({e for j, e in enumerate(support) if mask & (1 << j)})
                   for mask in range(1 << len(support))}
        targets = {edges for edges in targets if even(edges)}
        assert set(images) == targets
        checked += 1

print(f"PASS: {checked} cell sets; boundary map is bijective")
