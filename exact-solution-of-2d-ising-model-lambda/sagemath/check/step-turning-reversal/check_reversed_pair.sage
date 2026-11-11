"""Check the reversal identity for the three allowed direction differences."""

def turn(a, b):
    if b == a:
        return ZZ(0)
    if b == (a + 1) % 4:
        return ZZ(1)
    if b == (a - 1) % 4:
        return ZZ(-1)
    raise ValueError("backtracking pair")

for a in range(4):
    for b in range(4):
        if b == (a + 2) % 4:
            continue
        assert turn((b + 2) % 4, (a + 2) % 4) == -turn(a, b)

print("RESULT: PASS; all 12 nonbacktracking direction pairs")
