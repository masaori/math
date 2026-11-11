"""Check the four-cell classification of the oriented boundary turn."""

from itertools import product

checked = 0
for a, b, c, d in product((False, True), repeat=4):
    count = ZZ(a) + ZZ(b) + ZZ(c) + ZZ(d)
    if count not in (1, 2, 3) or (a and c and not b and not d) or (b and d and not a and not c):
        continue
    incoming = 2 if c and not b else 3 if d and not c else 0 if a and not d else 1
    outgoing = 0 if b and not c else 1 if c and not d else 2 if d and not a else 3
    incoming_exposed = (a != d, a != b, b != c, c != d)
    outgoing_exposed = (b != c, c != d, a != d, a != b)
    assert incoming_exposed[incoming]
    assert outgoing_exposed[outgoing]
    incoming_sides = ((a, d), (b, a), (c, b), (d, c))
    outgoing_sides = ((b, c), (c, d), (d, a), (a, b))
    assert incoming_sides[incoming] == (True, False)
    assert outgoing_sides[outgoing] == (True, False)
    assert [direction for direction in range(4)
            if incoming_sides[direction] == (True, False)] == [incoming]
    assert [direction for direction in range(4)
            if outgoing_sides[direction] == (True, False)] == [outgoing]
    incoming_side = (3, 0, 1, 2)[incoming]
    outgoing_side = (1, 2, 3, 0)[outgoing]
    assert incoming_side != outgoing_side
    difference = (outgoing - incoming) % 4
    turn = ZZ(1) if difference == 1 else ZZ(-1) if difference == 3 else ZZ(0)
    expected = ZZ(-1) if count == 1 else ZZ(1) if count == 3 else ZZ(0)
    assert turn == expected
    checked += 1

assert checked == 12
print("RESULT: PASS; all 12 admissible four-cell configurations")
