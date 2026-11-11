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

east_checked = 0
for a, b, c, d, e, f in product((False, True), repeat=6):
    source = (a, b, c, d)
    target = (b, e, f, c)
    if any(sum(ZZ(x) for x in cells) not in (1, 2, 3)
           or (cells[0] and cells[2] and not cells[1] and not cells[3])
           or (cells[1] and cells[3] and not cells[0] and not cells[2])
           for cells in (source, target)):
        continue
    outgoing = 0 if b and not c else 1 if c and not d else 2 if d and not a else 3
    if outgoing != 0:
        continue
    incoming_at_east = 2 if f and not e else 3 if c and not f else 0 if b and not c else 1
    assert incoming_at_east == 0
    east_checked += 1

assert east_checked > 0

west_checked = 0
for a, b, c, d, e, f in product((False, True), repeat=6):
    source = (a, b, c, d)
    target = (e, a, d, f)
    if any(sum(ZZ(x) for x in cells) not in (1, 2, 3)
           or (cells[0] and cells[2] and not cells[1] and not cells[3])
           or (cells[1] and cells[3] and not cells[0] and not cells[2])
           for cells in (source, target)):
        continue
    outgoing = 0 if b and not c else 1 if c and not d else 2 if d and not a else 3
    if outgoing != 2:
        continue
    incoming_at_west = 2 if d and not a else 3 if f and not d else 0 if e and not f else 1
    assert incoming_at_west == 2
    west_checked += 1

assert west_checked > 0

south_checked = 0
for a, b, c, d, e, f in product((False, True), repeat=6):
    source = (a, b, c, d)
    target = (d, c, e, f)
    if any(sum(ZZ(x) for x in cells) not in (1, 2, 3)
           or (cells[0] and cells[2] and not cells[1] and not cells[3])
           or (cells[1] and cells[3] and not cells[0] and not cells[2])
           for cells in (source, target)):
        continue
    outgoing = 0 if b and not c else 1 if c and not d else 2 if d and not a else 3
    if outgoing != 1:
        continue
    incoming_at_south = 2 if e and not c else 3 if f and not e else 0 if d and not f else 1
    assert incoming_at_south == 1
    south_checked += 1

assert south_checked > 0

north_checked = 0
for a, b, c, d, e, f in product((False, True), repeat=6):
    source = (a, b, c, d)
    target = (e, f, b, a)
    if any(sum(ZZ(x) for x in cells) not in (1, 2, 3)
           or (cells[0] and cells[2] and not cells[1] and not cells[3])
           or (cells[1] and cells[3] and not cells[0] and not cells[2])
           for cells in (source, target)):
        continue
    outgoing = 0 if b and not c else 1 if c and not d else 2 if d and not a else 3
    if outgoing != 3:
        continue
    incoming_at_north = 2 if b and not f else 3 if a and not b else 0 if e and not a else 1
    assert incoming_at_north == 3
    north_checked += 1

assert north_checked > 0
print(f"RESULT: PASS; {checked} local configurations, {east_checked} east-adjacent pairs, {west_checked} west-adjacent pairs, {south_checked} south-adjacent pairs, and {north_checked} north-adjacent pairs")
