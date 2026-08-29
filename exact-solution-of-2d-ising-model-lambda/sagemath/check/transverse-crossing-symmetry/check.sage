"""格子頂点での二つの通過の横断判定が順序に依らないことを有限データで厳密検査する。"""

def direction_axis(direction):
    return ZZ(direction % 2)

def step_turning(incoming, outgoing):
    residue = (outgoing - incoming) % 4
    if residue == 0:
        return ZZ(0)
    if residue == 1:
        return ZZ(1)
    if residue == 3:
        return ZZ(-1)
    return None

def transverse_crossing(first, second):
    incoming_1, outgoing_1 = first
    incoming_2, outgoing_2 = second
    return (step_turning(incoming_1, outgoing_1) == 0
            and step_turning(incoming_2, outgoing_2) == 0
            and direction_axis(incoming_1) != direction_axis(incoming_2))

visits = [(incoming, outgoing) for incoming in range(4) for outgoing in range(4)
          if step_turning(incoming, outgoing) is not None]
checked = 0
seen = set()
for first in visits:
    for second in visits:
        result = transverse_crossing(first, second)
        assert result == transverse_crossing(second, first)
        seen.add(result)
        checked += 1

assert seen == {False, True}
print(f"PASS: 局所通過 {checked} 組で横断判定の対称性を確認（横断・非横断とも出現）")
