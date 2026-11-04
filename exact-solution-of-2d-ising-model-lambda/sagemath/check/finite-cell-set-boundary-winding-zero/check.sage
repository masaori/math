"""Exact finite checks for claim_finite_cell_set_boundary_winding_zero."""

from itertools import combinations


def boundary_edges(L, i, j):
    return [
        (0, i, j, 1),
        (1, i, (j + 1) % L, 1),
        (0, (i + 1) % L, j, -1),
        (1, i, j, -1),
    ]


checked = 0
for L in (1, 2, 3):
    cells = [(i, j) for i in range(L) for j in range(L)]
    for count in range(len(cells) + 1):
        for chosen in combinations(cells, count):
            edges = [e for i, j in chosen for e in boundary_edges(L, i, j)]
            horizontal = sum(
                ZZ(sign) * ZZ(j == L - 1)
                for direction, i, j, sign in edges if direction == 0
            )
            vertical = sum(
                ZZ(sign) * ZZ(i == L - 1)
                for direction, i, j, sign in edges if direction == 1
            )
            assert horizontal == vertical == 0
            for direction in (0, 1):
                for i in range(L):
                    for j in range(L):
                        coefficient = sum(
                            ZZ(sign) for d, r, c, sign in edges
                            if (d, r, c) == (direction, i, j)
                        )
                        if direction == 0:
                            expected = ZZ((i, j) in chosen) - ZZ(((i - 1) % L, j) in chosen)
                        else:
                            expected = ZZ((i, (j - 1) % L) in chosen) - ZZ((i, j) in chosen)
                        assert coefficient == expected
            checked += 1

print("PASS: {} finite cell sets over ZZ".format(checked))
