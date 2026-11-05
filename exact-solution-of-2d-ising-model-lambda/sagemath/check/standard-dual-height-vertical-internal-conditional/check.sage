# 対象ラベル: claim_standard_dual_height_vertical_internal_conditional
from itertools import product
from random import Random

rng = Random(int(0))
checked = 0
for L in (2, 3, 4):
    patterns = product((0, 1), repeat=2 * L * L) if L == 2 else (
        [rng.randrange(2) for _ in range(2 * L * L)] for _ in range(1000)
    )
    for pattern in patterns:
        horizontal = {(r, c): ZZ(pattern[r * L + c]) for r in range(L) for c in range(L)}
        vertical = {(r, 0): ZZ(pattern[L * L + r]) for r in range(L)}
        for c in range(1, L):
            vertical[(0, c)] = ZZ(pattern[L * L + L + c - 1])
            for r in range(1, L):
                vertical[(r, c)] = (
                    vertical[(r - 1, c)] + horizontal[(r, c - 1)] + horizontal[(r, c)]
                ) % 2

        def height(i, j):
            column_sum = sum(vertical[(0, c)] for c in range(1, j + 1))
            row_sum = sum(horizontal[(r, j)] for r in range(1, i + 1))
            return (column_sum + row_sum) % 2

        for j in range(L - 1):
            for i in range(L):
                local = [
                    (horizontal[(r, j)] + horizontal[(r, j + 1)]
                     + vertical[(r - 1, j + 1)] + vertical[(r, j + 1)]) % 2
                    for r in range(1, i + 1)
                ]
                assert all(term == 0 for term in local)
                rectangle = (
                    sum(horizontal[(r, j)] for r in range(1, i + 1))
                    + sum(horizontal[(r, j + 1)] for r in range(1, i + 1))
                    + vertical[(0, j + 1)] + vertical[(i, j + 1)]
                ) % 2
                assert rectangle == 0
                before = height(i, j)
                after = height(i, j + 1)
                assert after == (before + vertical[(i, j + 1)]) % 2
                assert (after != before) == (vertical[(i, j + 1)] == 1)
                checked += 1
print(f"PASS: exact finite cases={checked}")
