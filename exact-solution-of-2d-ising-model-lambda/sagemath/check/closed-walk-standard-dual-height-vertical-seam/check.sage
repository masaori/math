# 対象ラベル: claim_closed_walk_standard_dual_height_vertical_seam
from itertools import product


def base_edge(row, col, direction, size):
    if direction == 0:
        return ("h", row, col)
    if direction == 1:
        return ("h", row, (col - 1) % size)
    if direction == 2:
        return ("v", row, col)
    return ("v", (row - 1) % size, col)


checked = 0
for size in (2, 3):
    for length in range(1, 8):
        for directions in product(range(4), repeat=length):
            row = col = 0
            walk = []
            for direction in directions:
                walk.append(base_edge(row, col, direction, size))
                dr, dc = ((0, 1), (0, -1), (1, 0), (-1, 0))[direction]
                row = (row + dr) % size
                col = (col + dc) % size
            if (row, col) != (0, 0):
                continue
            if any(directions[k] == (directions[(k + 1) % length] ^ 1)
                   for k in range(length)):
                continue

            def parity(edge):
                return sum(ZZ(e == edge) for e in walk) % 2

            seam = sum(ZZ(e[0] == "v" and e[1] == size - 1) for e in walk) % 2
            if seam != 0:
                continue
            for i in range(size):
                all_columns = sum(parity(("v", i, c)) for c in range(size))
                first = parity(("v", i, 0))
                remaining = sum(parity(("v", i, c)) for c in range(1, size))

                def height(j):
                    vertical = sum(parity(("v", 0, c)) for c in range(1, j + 1))
                    horizontal = sum(parity(("h", r, j)) for r in range(1, i + 1))
                    return (vertical + horizontal) % 2

                before = height(size - 1)
                after = height(0)
                assert all_columns % 2 == 0
                assert all_columns % 2 == (first + remaining) % 2
                assert (first + remaining) % 2 == 0
                assert after == (before + first) % 2
                assert (after != before) == (first == 1)
                checked += 1

print(f"PASS: {checked} exact vertical seam steps")
