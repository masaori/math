from itertools import combinations

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
                left = height(edges, row, column - 1)
                right = height(edges, row, column)
                indicator = ZZ(("v", ZZ(row), ZZ(column)) in edges)
                assert ((left == 1) != (right == 1)) == (left != right)
                assert (left != right) == (indicator == 1)
                assert (indicator == 1) == (("v", ZZ(row), ZZ(column)) in edges)
                cases += 1
print("PASS: %s vertical-edge membership cases" % cases)
