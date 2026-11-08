from itertools import combinations

def bit(edges, kind, row, column):
    return ZZ((kind, ZZ(row), ZZ(column)) in edges)

def height(edges, row, column):
    return sum((bit(edges, "v", row, j) for j in range(column + 1, 3)), ZZ(0)) % 2

def even_at(edges, row, column):
    return (bit(edges, "h", row, column)
            + bit(edges, "h", row, column - 1)
            + bit(edges, "v", row, column)
            + bit(edges, "v", row - 1, column)) % 2 == 0

universe = [(kind, ZZ(row), ZZ(column))
            for kind in ("h", "v")
            for row in (-1, 0)
            for column in (0, 1, 2)]
cases = 0
for size in range(len(universe) + 1):
    for chosen in combinations(universe, size):
        edges = frozenset(chosen)
        if not all(even_at(edges, row, column)
                   for row in (-1, 0, 1) for column in (0, 1, 2, 3)):
            continue
        for row in (0, 1):
            for column in (-1, 0, 1, 2):
                cutoff = 3
                vertical_sum = sum((bit(edges, "v", row, j)
                                    + bit(edges, "v", row - 1, j)
                                    for j in range(column + 1, cutoff + 1)), ZZ(0))
                horizontal_sum = sum((bit(edges, "h", row, j)
                                      + bit(edges, "h", row, j - 1)
                                      for j in range(column + 1, cutoff + 1)), ZZ(0))
                assert (height(edges, row, column)
                        + height(edges, row - 1, column) - vertical_sum) % 2 == 0
                assert (vertical_sum - horizontal_sum) % 2 == 0
                assert (horizontal_sum - bit(edges, "h", row, column)
                        - bit(edges, "h", row, cutoff)) % 2 == 0
                assert bit(edges, "h", row, cutoff) == 0
                assert (height(edges, row, column)
                        + height(edges, row - 1, column)
                        - bit(edges, "h", row, column)) % 2 == 0
                cases += 1
print("PASS: %s even-edge neighboring-cell cases" % cases)
