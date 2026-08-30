"""横断数零だけでは単純閉路の回転位相符号が従わない反例を厳密検査する。"""

L = 2
walk = [
    ("h", 0, 0, 0),
    ("h", 0, 1, 0),
    ("v", 0, 0, 0),
    ("h", 1, 0, 0),
    ("h", 1, 1, 0),
    ("v", 0, 0, 1),
]


def reversal(edge):
    kind, i, j, direction = edge
    return (kind, i, j, 1 - direction)


def endpoints(edge):
    kind, i, j, direction = edge
    boundary0 = (i, j)
    boundary1 = (i, (j + 1) % L) if kind == "h" else ((i + 1) % L, j)
    return (boundary0, boundary1) if direction == 0 else (boundary1, boundary0)


def direction_number(edge):
    kind, _, _, direction = edge
    return {("h", 0): 0, ("v", 0): 1, ("h", 1): 2, ("v", 1): 3}[(kind, direction)]


def turn(edge, successor):
    difference = (direction_number(successor) - direction_number(edge)) % 4
    assert difference in (0, 1, 3)
    return ZZ(0) if difference == 0 else (ZZ(1) if difference == 1 else ZZ(-1))


def crossing(k, l):
    m = len(walk)
    if endpoints(walk[k])[1] != endpoints(walk[l])[1]:
        return False
    straight_k = turn(walk[k], walk[(k + 1) % m]) == 0
    straight_l = turn(walk[l], walk[(l + 1) % m]) == 0
    axis_k = direction_number(walk[k]) % 2
    axis_l = direction_number(walk[l]) % 2
    return straight_k and straight_l and axis_k != axis_l


assert len(set(walk)) == len(walk)
for k in range(len(walk)):
    successor = walk[(k + 1) % len(walk)]
    assert endpoints(walk[k])[1] == endpoints(successor)[0]
    assert successor != reversal(walk[k])

crossing_number = ZZ(sum(
    1 for k in range(len(walk)) for l in range(k + 1, len(walk)) if crossing(k, l)))
turns = [turn(walk[k], walk[(k + 1) % len(walk)]) for k in range(len(walk))]
cyclic_turning = ZZ(sum(turns))
assert cyclic_turning % 4 == 0
rotation_number = cyclic_turning // 4
horizontal_indicators = [
    ZZ(1) if kind == "h" and j == L - 1 else ZZ(0) for kind, _, j, _ in walk]
vertical_indicators = [
    ZZ(1) if kind == "v" and i == L - 1 else ZZ(0) for kind, i, _, _ in walk]
horizontal_parity = ZZ(sum(horizontal_indicators) % 2)
vertical_parity = ZZ(sum(vertical_indicators) % 2)

assert crossing_number == 0
assert turns == [0, 1, -1, 0, -1, 1]
assert rotation_number == 0
assert horizontal_indicators == [0, 1, 0, 0, 1, 0]
assert vertical_indicators == [0, 0, 0, 0, 0, 0]
assert (horizontal_parity, vertical_parity) == (0, 0)
phase_sign = ZZ(-1) ** rotation_number
simple_loop_candidate = ZZ(-1) ** (
    1 + horizontal_parity + vertical_parity + horizontal_parity * vertical_parity)
assert phase_sign == 1
assert simple_loop_candidate == -1
assert phase_sign != simple_loop_candidate

print("PASS: edge-distinct closed nonbacktracking walk has crossing number 0, "
      "seam parity (0,0), rotation number 0, and phase sign 1 != -1 over ZZ")
