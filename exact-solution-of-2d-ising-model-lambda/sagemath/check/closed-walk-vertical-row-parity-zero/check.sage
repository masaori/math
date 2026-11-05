# 対象ラベル: claim_closed_walk_vertical_row_parity_zero
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
for size in (1, 2, 3):
    for length in range(1, 7):
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

            def parity(edge):
                return sum(ZZ(e == edge) for e in walk) % 2

            rows = [sum(parity(("v", i, j)) for j in range(size)) % 2
                    for i in range(size)]
            seam = sum(ZZ(e[0] == "v" and e[1] == size - 1) for e in walk) % 2
            assert rows[-1] == seam
            assert rows[0] == rows[-1]
            for i in range(size):
                assert rows[i] == rows[(i + 1) % size]
            if seam == 0:
                for i in range(size):
                    assert rows[i] == 0
                    checked += 1

print(f"PASS: {checked} exact zero-parity rows")
