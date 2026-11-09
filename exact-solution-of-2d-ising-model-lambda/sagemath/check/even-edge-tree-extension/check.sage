from itertools import combinations, product


def subsets(items):
    items = tuple(items)
    for size in range(len(items) + 1):
        for chosen in combinations(items, size):
            yield frozenset(chosen)


def trees(size):
    if size == 1:
        yield frozenset()
        return
    for word in product(range(size), repeat=size - 2):
        degrees = [1] * size
        for vertex in word:
            degrees[vertex] += 1
        chosen = set()
        for vertex in word:
            leaf = next(v for v in range(size) if degrees[v] == 1)
            chosen.add(tuple(sorted((leaf, vertex))))
            degrees[leaf] -= 1
            degrees[vertex] -= 1
        chosen.add(tuple(v for v in range(size) if degrees[v] == 1))
        yield frozenset(chosen)


checked = 0
for size in range(1, 5):
    vertices = range(size)
    all_edges = frozenset(combinations(vertices, 2))
    for tree in trees(size):
        chords = all_edges - tree
        for selected_chords in subsets(chords):
            matching = [
                selected for selected in subsets(all_edges)
                if selected & chords == selected_chords
                and all(sum(v in edge for edge in selected) % 2 == 0
                        for v in vertices)
            ]
            assert len(matching) == 1
            checked += 1

print("PASS: %s trees and prescribed non-tree edge sets" % checked)
