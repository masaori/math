from itertools import combinations

universe = [(kind, ZZ(row), ZZ(column))
            for kind in ("h", "v")
            for row in (-1, 0, 1)
            for column in (-1, 0, 1)]
cases = 0
for size in range(4):
    for chosen in combinations(universe, size):
        edges = frozenset(chosen)
        bound = max((edge[2] for edge in edges), default=ZZ(0))
        for row in range(-2, 3):
            for column in range(bound, bound + 3):
                crossings = frozenset(edge for edge in edges
                                      if edge[0] == "v" and edge[1] == row
                                      and edge[2] > column)
                assert crossings == frozenset()
                assert ZZ(len(crossings)) % 2 == 0
                cases += 1
print("PASS: %s right-bound cases" % cases)
