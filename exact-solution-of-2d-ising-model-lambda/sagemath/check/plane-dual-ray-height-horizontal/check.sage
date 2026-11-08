from itertools import combinations

ZZ0 = ZZ(0)

def height(edges, row, column):
    return ZZ(sum(ZZ(edge[0] == "v" and edge[1] == row and edge[2] > column)
                  for edge in edges)) % 2

universe = [(kind, ZZ(row), ZZ(column))
            for kind in ("h", "v")
            for row in (-1, 0)
            for column in (-1, 0, 1)]
cases = 0
for size in range(len(universe) + 1):
    for chosen in combinations(universe, size):
        edges = frozenset(chosen)
        for row in (-1, 0):
            for column in (-2, -1, 0, 1, 2):
                left_crossings = ZZ(sum(ZZ(edge[0] == "v" and edge[1] == row
                                             and edge[2] > column - 1)
                                         for edge in edges))
                shared_crossing = ZZ(("v", ZZ(row), ZZ(column)) in edges)
                right_crossings = ZZ(sum(ZZ(edge[0] == "v" and edge[1] == row
                                              and edge[2] > column)
                                          for edge in edges))
                assert left_crossings == shared_crossing + right_crossings
                assert height(edges, row, column - 1) == (
                    height(edges, row, column) + shared_crossing) % 2
                cases += 1
print("PASS: %s finite-set and neighboring-cell cases" % cases)
