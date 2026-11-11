"""Check the four-cell classification of the oriented boundary turn."""

from itertools import product

checked = 0
for a, b, c, d in product((False, True), repeat=4):
    count = ZZ(a) + ZZ(b) + ZZ(c) + ZZ(d)
    if count not in (1, 2, 3) or (a and c and not b and not d) or (b and d and not a and not c):
        continue
    incoming = 2 if c and not b else 3 if d and not c else 0 if a and not d else 1
    outgoing = 0 if b and not c else 1 if c and not d else 2 if d and not a else 3
    difference = (outgoing - incoming) % 4
    turn = ZZ(1) if difference == 1 else ZZ(-1) if difference == 3 else ZZ(0)
    expected = ZZ(-1) if count == 1 else ZZ(1) if count == 3 else ZZ(0)
    assert turn == expected
    checked += 1

assert checked == 12
print("RESULT: PASS; all 12 admissible four-cell configurations")
