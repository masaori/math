from itertools import combinations

def height(edges, row, column):
    return ZZ(sum(ZZ(edge[0] == "v" and edge[1] == row and edge[2] > column)
                  for edge in edges)) % 2

def even_at_vertex(edges, row, column):
    incident = (("h", row, column), ("h", row, column - 1),
                ("v", row, column), ("v", row - 1, column))
    return sum(ZZ(edge in edges) for edge in incident) % 2 == 0

universe = [(kind, ZZ(row), ZZ(column))
            for kind in ("h", "v")
            for row in (-1, 0, 1)
            for column in (-1, 0, 1)]
cases = 0
for size in range(len(universe) + 1):
    for chosen in combinations(universe, size):
        edges = frozenset(chosen)
        if not all(even_at_vertex(edges, row, column)
                   for row in (-1, 0, 1, 2)
                   for column in (-1, 0, 1, 2)):
            continue
        cells = frozenset((ZZ(row), ZZ(column))
                          for row in range(-2, 3)
                          for column in range(-2, 3)
                          if height(edges, row, column) == 1)
        for row in (0, 1):
            for column in (-1, 0, 1):
                top = height(edges, row, column)
                bottom = height(edges, row - 1, column)
                indicator = ZZ(("h", ZZ(row), ZZ(column)) in edges)
                assert ((top == 1) != (bottom == 1)) == (top != bottom)
                assert (top != bottom) == (((top + bottom) % 2) == 1)
                assert ((top + bottom) % 2) == indicator
                assert (indicator == 1) == (("h", ZZ(row), ZZ(column)) in edges)
                boundary = (((ZZ(row), ZZ(column)) in cells) !=
                            ((ZZ(row - 1), ZZ(column)) in cells))
                assert boundary == ((top == 1) != (bottom == 1))
                assert boundary == (("h", ZZ(row), ZZ(column)) in edges)
                cases += 1
print("PASS: %s horizontal-edge membership cases" % cases)
