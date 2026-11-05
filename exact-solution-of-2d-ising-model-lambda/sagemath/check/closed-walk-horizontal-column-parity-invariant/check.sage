# 対象ラベル: claim_closed_walk_horizontal_column_parity_invariant
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

            for j in range(size):
                for i in range(size):
                    assert (parity(("h", i, (j + 1) % size))
                            + parity(("h", i, j))
                            + parity(("v", i, (j + 1) % size))
                            + parity(("v", (i - 1) % size, (j + 1) % size))) % 2 == 0
                before = sum(parity(("h", i, j)) for i in range(size)) % 2
                after = sum(parity(("h", i, (j + 1) % size)) for i in range(size)) % 2
                vertical = sum(parity(("v", i, (j + 1) % size)) for i in range(size))
                shifted_vertical = sum(parity(("v", (i - 1) % size, (j + 1) % size))
                                       for i in range(size))
                assert vertical == shifted_vertical
                assert (before + after + vertical + shifted_vertical) % 2 == 0
                assert after == (sum(parity(("h", i, j)) for i in range(size))
                                 + shifted_vertical + vertical) % 2
                assert after == (sum(parity(("h", i, j)) for i in range(size))
                                 + 2 * vertical) % 2
                assert before == after
                checked += 1

print(f"PASS: {checked} exact adjacent-column parities of closed walks")
