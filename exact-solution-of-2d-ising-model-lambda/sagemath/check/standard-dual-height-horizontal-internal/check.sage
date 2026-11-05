# 対象ラベル: claim_standard_dual_height_horizontal_internal
from itertools import product
from random import Random

rng = Random(int(0))
checked = 0

for L in (2, 3, 4):
    patterns = product((0, 1), repeat=2 * L * L) if L == 2 else (
        [rng.randrange(2) for _ in range(2 * L * L)] for _ in range(1000)
    )
    for pattern in patterns:
        vertical = {(r, c): ZZ(pattern[r * L + c]) for r in range(L) for c in range(L)}
        horizontal = {(r, c): ZZ(pattern[L * L + r * L + c]) for r in range(L) for c in range(L)}
        def height(i, j):
            return (sum(vertical[(0, c)] for c in range(1, j + 1))
                    + sum(horizontal[(r, j)] for r in range(1, i + 1))) % 2
        for i in range(L - 1):
            for j in range(L):
                edge = horizontal[(i + 1, j)]
                before = height(i, j)
                after = height(i + 1, j)
                assert after == (before + edge) % 2
                assert (after != before) == (edge == 1)
                checked += 1
print(f"PASS: exact finite cases={checked}")
