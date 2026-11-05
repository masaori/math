# 対象ラベル: claim_standard_dual_height_vertical_seam_conditional
from itertools import product
from random import Random


rng = Random(int(0))
checked = 0
for size in (2, 3, 4):
    patterns = product((0, 1), repeat=2 * size * size) if size == 2 else (
        [rng.randrange(2) for _ in range(2 * size * size)] for _ in range(3000)
    )
    for pattern in patterns:
        vertical = {(r, c): ZZ(pattern[r * size + c])
                    for r in range(size) for c in range(size)}
        horizontal = {(r, c): ZZ(pattern[size * size + r * size + c])
                      for r in range(size) for c in range(size)}

        def height(i, j):
            return (sum(vertical[(0, c)] for c in range(1, j + 1)) +
                    sum(horizontal[(r, j)] for r in range(1, i + 1))) % 2

        for i in range(size):
            if any((horizontal[(r, j)] + horizontal[(r, j + 1)] +
                    vertical[(r - 1, j + 1)] + vertical[(r, j + 1)]) % 2
                   for j in range(size - 1) for r in range(1, i + 1)):
                continue
            line = sum(vertical[(i, c)] for c in range(1, size)) + vertical[(i, 0)]
            if line % 2:
                continue
            assert (height(i, 0) + sum(vertical[(i, c)] for c in range(1, 1))) % 2 == height(i, 0)
            for j in range(size):
                assert height(i, j) == (height(i, 0) +
                    sum(vertical[(i, c)] for c in range(1, j + 1))) % 2
                if j + 1 < size:
                    step = (height(i, j) + vertical[(i, j + 1)]) % 2
                    substituted = ((height(i, 0) +
                        sum(vertical[(i, c)] for c in range(1, j + 1))) % 2 +
                        vertical[(i, j + 1)]) % 2
                    flattened = (height(i, 0) +
                        sum(vertical[(i, c)] for c in range(1, j + 1)) +
                        vertical[(i, j + 1)]) % 2
                    extended = (height(i, 0) +
                        sum(vertical[(i, c)] for c in range(1, j + 2))) % 2
                    assert height(i, j + 1) == step
                    assert step == substituted
                    assert substituted == flattened
                    assert flattened == extended
            before = height(i, size - 1)
            after = height(i, 0)
            crossing = vertical[(i, 0)]
            substituted_last = ((after + sum(vertical[(i, c)] for c in range(1, size))) % 2 + crossing) % 2
            flattened_last = (after + sum(vertical[(i, c)] for c in range(1, size)) + crossing) % 2
            assert (before + crossing) % 2 == substituted_last
            assert substituted_last == flattened_last
            assert flattened_last == after % 2
            assert after % 2 == after
            assert (before + crossing) % 2 == after
            assert (after != before) == (crossing == 1)
            checked += 1

print(f"PASS: {checked} exact conditional vertical seam steps")
