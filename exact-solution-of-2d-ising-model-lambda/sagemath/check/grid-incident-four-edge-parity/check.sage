from itertools import combinations

try:
    ZZ
except NameError:
    ZZ = int

vertex = (2, -3)
r, c = vertex
incident = ((0, r, c), (0, r, c - 1), (1, r, c), (1, r - 1, c))
other = ((0, r + 2, c), (1, r, c + 2))
universe = incident + other

def endpoints(edge):
    direction, row, column = edge
    if direction == 0:
        return {(row, column), (row, column + 1)}
    return {(row, column), (row + 1, column)}

for size in range(len(universe) + 1):
    for chosen in combinations(universe, size):
        subset = set(chosen)
        incident_count = ZZ(sum(vertex in endpoints(edge) for edge in subset))
        four_count = ZZ(sum(edge in subset for edge in incident))
        assert incident_count == four_count
        assert (four_count % 2 == 0) == (incident_count % 2 == 0)

print("PASS: 64 finite edge subsets; incidence count and parity agree")
