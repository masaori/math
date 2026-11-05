# 対象ラベル: claim_standard_dual_rectangle_parity
from itertools import product
from random import Random

rng = Random(int(0))
checked = 0

for L in (2, 3, 4):
    patterns = product((0, 1), repeat=2 * L * L) if L == 2 else (
        [rng.randrange(2) for _ in range(2 * L * L)] for _ in range(2000)
    )
    for pattern in patterns:
        horizontal = {(r, c): ZZ(pattern[r * L + c]) for r in range(L) for c in range(L)}
        vertical = {(r, c): ZZ(pattern[L * L + r * L + c]) for r in range(L) for c in range(L)}
        for i in range(L):
            for j in range(L - 1):
                local = [
                    (horizontal[(r, j)] + horizontal[(r, j + 1)]
                     + vertical[(r - 1, j + 1)] + vertical[(r, j + 1)]) % 2
                    for r in range(1, i + 1)
                ]
                if any(local):
                    continue
                prior = ZZ(0)
                for r in range(1, i + 1):
                    current = (
                        sum(horizontal[(s, j)] for s in range(1, r + 1))
                        + sum(horizontal[(s, j + 1)] for s in range(1, r + 1))
                        + vertical[(0, j + 1)] + vertical[(r, j + 1)]
                    ) % 2
                    assert current == (prior + local[r - 1]) % 2
                    prior = current
                whole = (
                    sum(horizontal[(r, j)] for r in range(1, i + 1))
                    + sum(horizontal[(r, j + 1)] for r in range(1, i + 1))
                    + vertical[(0, j + 1)] + vertical[(i, j + 1)]
                ) % 2
                assert whole == prior == 0
                checked += 1
print(f"PASS: exact finite cases={checked}")
