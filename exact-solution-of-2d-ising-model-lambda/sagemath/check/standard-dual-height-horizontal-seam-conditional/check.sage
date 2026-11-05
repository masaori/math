# 対象ラベル: claim_standard_dual_height_horizontal_seam_conditional
from itertools import product
from random import Random


rng = Random(int(0))
checked = 0
for size in (2, 3, 4):
    patterns = product((0, 1), repeat=2 * size * size) if size == 2 else (
        [rng.randrange(2) for _ in range(2 * size * size)] for _ in range(1000)
    )
    for pattern in patterns:
        vertical = {(r, c): ZZ(pattern[r * size + c])
                    for r in range(size) for c in range(size)}
        horizontal = {(r, c): ZZ(pattern[size * size + r * size + c])
                      for r in range(size) for c in range(size)}

        def height(i, j):
            column = sum(vertical[(0, c)] for c in range(1, j + 1))
            row = sum(horizontal[(r, j)] for r in range(1, i + 1))
            return (column + row) % 2

        for j in range(size):
            column = sum(vertical[(0, c)] for c in range(1, j + 1))
            row = sum(horizontal[(r, j)] for r in range(1, size))
            line = row + horizontal[(0, j)]
            if line % 2 != 0:
                continue
            before = height(size - 1, j)
            after = height(0, j)
            crossing = horizontal[(0, j)]
            assert after == column % 2
            assert before == (column + row) % 2
            assert (row + crossing) % 2 == 0
            assert (before + crossing) % 2 == (column + row + crossing) % 2
            assert (column + row + crossing) % 2 == column % 2
            assert after == (before + crossing) % 2
            assert (after != before) == (crossing == 1)
            checked += 1

print(f"PASS: {checked} exact conditional horizontal seam steps")
