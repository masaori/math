# 対象ラベル: claim_plane_dual_ray_height_zero_left
# 頂点の偶数次数と左端の横辺の不在から、隣接二行の高さが等しいことを検算する。
from itertools import combinations

universe = ([("h", ZZ(r), ZZ(c)) for r in range(3) for c in range(2)] +
            [("v", ZZ(r), ZZ(c)) for r in range(2) for c in range(3)])

def even_at_every_vertex(edges):
    return all(ZZ(sum(("h", r, c) in edges for c in (c0 - 1, c0)) +
                  sum(("v", r, c0) in edges for r in (r0 - 1, r0))) % 2 == 0
               for r0 in range(3) for c0 in range(3)
               for r in (r0,))

def height(edges, row, column):
    return ZZ(sum(kind == "v" and r == row and column < c
                  for kind, r, c in edges)) % 2

even_sets = []
checks = 0
for size in range(len(universe) + 1):
    for chosen in combinations(universe, size):
        edges = frozenset(chosen)
        if not even_at_every_vertex(edges):
            continue
        even_sets.append(edges)
        lower = min((edge[2] for edge in edges), default=ZZ(0))
        for row in range(-1, 4):
            column = lower - 1
            horizontal = ZZ(("h", ZZ(row), ZZ(column)) in edges)
            top = height(edges, ZZ(row), column)
            bottom = height(edges, ZZ(row) - 1, column)
            assert horizontal == 0
            assert (top + bottom) % 2 == horizontal
            assert top == bottom
            checks += 1
print("PASS: %s adjacent-row cases over %s even edge sets" % (checks, len(even_sets)))
