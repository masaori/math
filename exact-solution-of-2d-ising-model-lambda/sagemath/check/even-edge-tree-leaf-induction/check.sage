from itertools import combinations, product


def edges(vertices):
    return set(combinations(vertices, 2))


def subsets(items):
    for size in range(len(items) + 1):
        for chosen in combinations(items, size):
            yield set(chosen)


def prufer_tree(size, word):
    degrees = [1] * size
    for vertex in word:
        degrees[vertex] += 1
    result = set()
    for vertex in word:
        leaf = next(v for v in range(size) if degrees[v] == 1)
        result.add(tuple(sorted((leaf, vertex))))
        degrees[leaf] -= 1
        degrees[vertex] -= 1
    remaining = [v for v in range(size) if degrees[v] == 1]
    result.add(tuple(remaining))
    return result


def extend(size, tree, chords, root):
    selected = set(chords)
    remaining = set(range(size))
    while len(remaining) > 1:
        leaf = next(v for v in sorted(remaining - {root})
                    if sum(v in edge and set(edge) <= remaining for edge in tree) == 1)
        edge = next(edge for edge in tree if leaf in edge and set(edge) <= remaining)
        if sum(leaf in chosen for chosen in selected) % 2:
            selected.add(edge)
        assert sum(leaf in chosen for chosen in selected) % 2 == 0
        remaining.remove(leaf)
    return selected


checked = 0
for size in range(1, 6):
    vertices = range(size)
    words = [()] if size <= 2 else product(vertices, repeat=size - 2)
    for word in words:
        tree = set() if size == 1 else prufer_tree(size, word)
        available_chords = sorted(edges(vertices) - tree)
        for chords in subsets(available_chords):
            for root in vertices:
                selected = extend(size, tree, chords, root)
                assert selected - tree == chords
                assert all(sum(v in edge for edge in selected) % 2 == 0 for v in vertices if v != root)
                checked += 1

print("PASS: %s tree, chord and root choices" % checked)
