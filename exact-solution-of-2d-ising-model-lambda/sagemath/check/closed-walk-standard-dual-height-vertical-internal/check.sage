# 対象ラベル: claim_closed_walk_standard_dual_height_vertical_internal
from itertools import product


def edge_for_step(row, col, direction, size):
    if direction == 0:
        return ("h", row, col)
    if direction == 1:
        return ("h", row, (col - 1) % size)
    if direction == 2:
        return ("v", row, col)
    return ("v", (row - 1) % size, col)


checked = 0
for size in (2, 3):
    for length in range(1, 7):
        for directions in product(range(4), repeat=length):
            row, col = 0, 0
            walk = []
            for direction in directions:
                walk.append(edge_for_step(row, col, direction, size))
                dr, dc = ((0, 1), (0, -1), (1, 0), (-1, 0))[direction]
                row = (row + dr) % size
                col = (col + dc) % size
            if (row, col) != (0, 0):
                continue

            def parity(edge):
                return sum(ZZ(item == edge) for item in walk) % 2

            def height(i, j):
                return (sum(parity(("v", 0, c)) for c in range(1, j + 1))
                        + sum(parity(("h", r, j)) for r in range(1, i + 1))) % 2

            for j in range(size - 1):
                for i in range(size):
                    for r in range(1, i + 1):
                        assert (parity(("h", r, j)) + parity(("h", r, j + 1))
                                + parity(("v", r - 1, j + 1))
                                + parity(("v", r, j + 1))) % 2 == 0
                    before = height(i, j)
                    after = height(i, j + 1)
                    crossing = parity(("v", i, j + 1))
                    assert after == (before + crossing) % 2
                    assert (after != before) == (crossing == 1)
                    checked += 1

print(f"PASS: {checked} exact vertical steps of closed walks")
