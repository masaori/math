from itertools import combinations


def subsets(items):
    for size in range(len(items) + 1):
        for selected in combinations(items, size):
            yield frozenset(selected)


checked = 0
for size in range(2, 6):
    vertices = tuple(range(size))
    possible_edges = tuple(combinations(vertices, 2))
    for edges in subsets(possible_edges):
        for selected in subsets(tuple(edges)):
            for edge in edges:
                for vertex in edge:
                    toggled = selected.symmetric_difference({edge})
                    parity = sum(vertex in item for item in selected) % 2
                    toggled_parity = sum(vertex in item for item in toggled) % 2
                    assert toggled_parity == (parity + 1) % 2
                    assert (parity == 0) != (toggled_parity == 0)
                    checked += 1

print("PASS: %s incident-edge choices" % checked)
