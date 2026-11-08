from itertools import combinations

universe = [(kind, ZZ(row), ZZ(column))
            for kind in ("h", "v")
            for row in (-1, 0, 1)
            for column in (-1, 0, 1)]
cases = 0
for size in range(4):
    for chosen in combinations(universe, size):
        edges = frozenset(chosen)
        rows = frozenset(edge[1] for edge in edges)
        for row in range(-2, 3):
            for column in range(-2, 3):
                crossings = frozenset(edge for edge in edges
                                      if edge[0] == "v" and edge[1] == row
                                      and edge[2] > column)
                height = ZZ(len(crossings)) % 2
                if row not in rows:
                    assert crossings == frozenset()
                    assert height == 0
                if height == 1:
                    assert row in rows
                cases += 1
print("PASS: %s finite-row-support cases" % cases)
