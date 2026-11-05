# 対象ラベル: claim_closed_walk_vertical_row_parity_invariant
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
for size in (1, 2, 3):
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
                return sum(int(item == edge) for item in walk) % 2

            for i in range(size):
                for j in range(size):
                    assert (parity(("v", i, j))
                            + parity(("v", (i + 1) % size, j))
                            + parity(("h", (i + 1) % size, (j - 1) % size))
                            + parity(("h", (i + 1) % size, j))) % 2 == 0
                before = sum(parity(("v", i, j)) for j in range(size)) % 2
                after = sum(parity(("v", (i + 1) % size, j)) for j in range(size)) % 2
                horizontal = sum(parity(("h", (i + 1) % size, j)) for j in range(size))
                shifted = sum(parity(("h", (i + 1) % size, (j - 1) % size))
                              for j in range(size))
                assert horizontal == shifted
                assert (before + after + horizontal + shifted) % 2 == 0
                assert after == (sum(parity(("v", i, j)) for j in range(size))
                                 + horizontal + shifted) % 2
                assert after == (sum(parity(("v", i, j)) for j in range(size))
                                 + 2 * horizontal) % 2
                assert before == after
                checked += 1

print(f"PASS: {checked} exact adjacent-row parities of closed walks")
